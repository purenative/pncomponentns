import AVFoundation

public enum CameraAction {
    
    case takePhoto(AVCapturePhotoSettings)
    
    case toggleFlashLight
    
    case startRecordingVideo
    case stopRecordingVideo
    
}
