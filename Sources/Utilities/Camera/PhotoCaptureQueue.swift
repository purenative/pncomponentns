import Foundation
import AVFoundation

final class PhotoCaptureQueue {
    
    private let capturingOperationQueue: OperationQueue
    
    init() {
        capturingOperationQueue = OperationQueue()
        capturingOperationQueue.name = "com.pncomponents.Camera.PhotoCapturingUnit"
        capturingOperationQueue.maxConcurrentOperationCount = 1
        capturingOperationQueue.qualityOfService = .userInitiated
    }
    
    func capturePhoto(withSettings settings: AVCapturePhotoSettings,
                      forPhotoOutput photoOutput: AVCapturePhotoOutput,
                      onResult: @escaping (PhotoCaptureOperation.CaptureResult) -> Void) {
        
        let operation = PhotoCaptureOperation(
            photoOutput: photoOutput,
            settings: settings
        )
        
        operation.completionBlock = {
            onResult(operation.result)
        }
        
        capturingOperationQueue.addOperation(operation)
    }
    
}
