import Foundation

public extension VariableFont {
    
    struct Width: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let compressed   = Width([])
        public static let condensed    = Width(rawValue: 50)
        public static let standard     = Width(rawValue: 100)
        public static let expanded     = Width(rawValue: 300)
        
    }
    
}
