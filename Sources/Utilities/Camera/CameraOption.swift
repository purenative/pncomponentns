import Foundation

public struct CameraOption: OptionSet {
    
    public let rawValue: UInt64
    
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
}

public extension CameraOption {
    
    static let photoCapturing = CameraOption(rawValue: 1 << 0)
    static let movieRecording = CameraOption(rawValue: 1 << 1)
    
}
