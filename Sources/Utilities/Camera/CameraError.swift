import Foundation
import AVFoundation

public enum CameraError: Error {
    
    case originalError(Error)
    
    case initializationFailed(reason: InitializationFailedReason)
    
    public enum InitializationFailedReason {
        case cantFindVideoDevice(postition: AVCaptureDevice.Position, deviceType: AVCaptureDevice.DeviceType)
        case cantCreateVideoDeviceInput(position: AVCaptureDevice.Position, deviceType: AVCaptureDevice.DeviceType)
        case cantAddVideoDeviceInputToSession(position: AVCaptureDevice.Position, deviceType: AVCaptureDevice.DeviceType)
        
        case cantAddPhotoCapturingOutput
        case cantAddMovieFileOutput
    }
    
    case photoCapturingFailed(reason: PhotoCapturingFailedReason)

    public enum PhotoCapturingFailedReason {
        case photoOutputNotConfigured
    }
    
    case movieRecordingFailed(reason: MovieRecordingFailedReason)
    
    public enum MovieRecordingFailedReason {
        case movieOutputNotConfigured
        
        case movieRecordingNotStarted
        case movieRecordingNotFinished
    }
    
}
