import Foundation
import CoreGraphics

public enum CameraActionResult {
    
    case successed
    case capturedImage(CGImage?)
    case movieRecordedTo(URL)
    
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
    
    func getRecordedMovieURL() -> URL? {
        switch self {
        case let .movieRecordedTo(url):
            return url
            
        default:
            return nil
        }
    }
    
}
