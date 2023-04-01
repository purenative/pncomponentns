import Foundation
import CoreGraphics

public enum CameraActionResult {
    
    case successed
    case capturedImage(CGImage?)
    
}

public extension CameraActionResult {
    
    func getCapturedImage() -> CGImage? {
        switch self {
        case let .capturedImage(image):
            return image
            
        default:
            return nil
        }
    }
    
}
