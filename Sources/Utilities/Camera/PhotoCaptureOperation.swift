import Foundation
import AVFoundation

final class PhotoCaptureOperation: Operation, AVCapturePhotoCaptureDelegate {
    
    typealias CaptureResult = Result<CGImage?, Error>
    
    let photoOutput: AVCapturePhotoOutput
    let settings: AVCapturePhotoSettings
    
    var result: CaptureResult!
    
    init(photoOutput: AVCapturePhotoOutput, settings: AVCapturePhotoSettings) {
        self.photoOutput = photoOutput
        self.settings = settings
    }
    
    override func main() {
        photoOutput.capturePhoto(
            with: settings,
            delegate: self
        )
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
    }
    
}
