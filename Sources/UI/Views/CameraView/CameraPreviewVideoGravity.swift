import AVFoundation

public enum CameraPreviewVideoGravity {
    
    case scaleAspectFit
    case scaleAspectFill
    case resize
    
}

extension CameraPreviewVideoGravity {
    
    func getAVLayerVideoGravity() -> AVLayerVideoGravity {
        switch self {
        case .scaleAspectFit:
            return .resizeAspect

        case .scaleAspectFill:
            return .resizeAspectFill

        case .resize:
            return .resize
        }
    }
    
}
