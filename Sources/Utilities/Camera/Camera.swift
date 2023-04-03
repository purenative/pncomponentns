import Foundation
import AVFoundation

public final class Camera {
    
    public typealias ActionRunningResult = Result<CameraActionResult, CameraError>
    
    private let cameraQueue = DispatchQueue(
        label: "com.pncomponents.Camera",
        qos: .background
    )
    
    let captureSession: AVCaptureSession
    
    private var videoCaptureDevice: AVCaptureDevice!
    private var videoCaptureDeviceInput: AVCaptureDeviceInput!
    
    private var photoOutput: AVCapturePhotoOutput!
    private var photoCaptureQueue: PhotoCaptureQueue!
    
    public init(options: CameraOption,
                position: AVCaptureDevice.Position,
                deviceType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera) throws {
        
        captureSession = AVCaptureSession()
        
        try setupForPosition(
            position,
            withDeviceType: deviceType
        )
        
        if options.contains(.photoCapturing) {
            try initPhotoCapturing()
        }
        
        if options.contains(.videoRecording) {
            
        }
        
        #if DEBUG
        print("Camera inited")
        #endif
    }
    
    deinit {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
        
        #if DEBUG
        print("Camera deinited")
        #endif
    }
    
    public func start() {
        cameraQueue.async { [weak self] in
            self?.captureSession.startRunning()
            
            #if DEBUG
            print("Camera session started")
            #endif
        }
    }
    
    public func stop() {
        cameraQueue.async { [weak self] in
            self?.captureSession.stopRunning()
            
            #if DEBUG
            print("Camera session stopped")
            #endif
        }
    }
    
    public func setupForPosition(_ position: AVCaptureDevice.Position,
                                 withDeviceType deviceType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera) throws {
        
        // MARK: - Video device initialization
        videoCaptureDevice = AVCaptureDevice.default(
            deviceType,
            for: .video,
            position: position
        )
        
        guard let videoCaptureDevice else {
            let reason = CameraError.InitializationFailedReason.cantFindVideoDevice(
                postition: position,
                deviceType: deviceType
            )
            throw CameraError.initializationFailed(reason: reason)
        }
        
        // MARK: - Video device input initialization
        videoCaptureDeviceInput = try? AVCaptureDeviceInput(device: videoCaptureDevice)
        
        guard let videoCaptureDeviceInput else {
            let reason = CameraError.InitializationFailedReason.cantCreateVideoDeviceInput(
                position: position,
                deviceType: deviceType
            )
            throw CameraError.initializationFailed(reason: reason)
        }
        
        guard captureSession.canAddInput(videoCaptureDeviceInput) else {
            let reason = CameraError.InitializationFailedReason.cantAddVideoDeviceInputToSession(
                position: position,
                deviceType: deviceType
            )
            throw CameraError.initializationFailed(reason: reason)
        }
        
        captureSession.addInput(videoCaptureDeviceInput)
    }
    
    public func run(action: CameraAction,
                    onResult: @escaping (ActionRunningResult) -> Void) {
        
        switch action {
        case let .takePhoto(settings):
            takePhoto(withSettings: settings) { result in
                switch result {
                case let .success(image):
                    onResult(.success(.capturedImage(image)))
                    
                case let .failure(error):
                    onResult(.failure(.originalError(error)))
                }
            }
            
        default:
            fatalError("Action not supported by Camera")
        }
    }

    public func run(action: CameraAction) async throws -> CameraActionResult {
        try await withCheckedThrowingContinuation { continuation in
            run(action: action) { result in
                continuation.resume(with: result)
            }
        }
    }
    
}

private extension Camera {
    
    func initPhotoCapturing() throws {
        
        photoOutput = AVCapturePhotoOutput()
        
        guard captureSession.canAddOutput(photoOutput) else {
            let reason = CameraError.InitializationFailedReason.cantAddPhotoCapturingOutput
            throw CameraError.initializationFailed(reason: reason)
        }
        
        captureSession.addOutput(photoOutput)
        
        photoCaptureQueue = PhotoCaptureQueue()
        
    }
    
    func takePhoto(withSettings settings: AVCapturePhotoSettings,
                   onResult: @escaping (PhotoCaptureOperation.CaptureResult) -> Void) {
        
        if let photoOutput {
            photoCaptureQueue.capturePhoto(
                withSettings: settings,
                forPhotoOutput: photoOutput,
                onResult: onResult
            )
        } else {
            let reason = CameraError.PhotoCapturingFailedReason.photoOutputNotConfigured
            let error = CameraError.photoCapturingFailed(reason: reason)
            let result = PhotoCaptureOperation.CaptureResult.failure(error)
            onResult(result)
        }
    }
    
}
