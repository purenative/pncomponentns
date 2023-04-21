import AVFoundation

public enum CameraAction {
    
    case takePhoto(AVCapturePhotoSettings)
    
    case toggleFlashLight
    
    case startMovieRecording(movieFileURL: URL)
    case stopMovieRecording
    
}
