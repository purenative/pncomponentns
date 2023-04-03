import Foundation
import AVFoundation

final class PhotoCaptureOperation: Operation, AVCapturePhotoCaptureDelegate {
    
    typealias CaptureResult = Result<CGImage?, Error>
    
    private(set) var state: OperationState = .ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    override var isExecuting: Bool {
        state == .executing
    }
    override var isFinished: Bool {
        state == .finished
    }
    
    override var isAsynchronous: Bool {
        true
    }
    
    let photoOutput: AVCapturePhotoOutput
    let settings: AVCapturePhotoSettings
    
    var result: CaptureResult!
    
    init(photoOutput: AVCapturePhotoOutput, settings: AVCapturePhotoSettings) {
        self.photoOutput = photoOutput
        self.settings = settings
        
        state = .ready
    }
    
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    override func main() {
        photoOutput.capturePhoto(
            with: settings,
            delegate: self
        )
    }
    
    func finish() {
        state = .finished
    }
    
    override func cancel() {
        super.cancel()
        
        result = .success(nil)
        finish()
    }
    
    // MARK: - AVCapturePhotoCaptureDelegate
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let error {
            result = .failure(error)
        } else {
            let cgImage = photo.cgImageRepresentation()
            result = .success(cgImage)
        }
        
        finish()
    }
    
}
