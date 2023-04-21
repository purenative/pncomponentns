import Foundation

enum OperationState: String, CaseIterable {
    
    case ready
    case executing
    case finished
    
    var keyPath: String {
        "is" + rawValue.capitalized
    }
    
}
