import Foundation

public extension VariableFont {
    
    struct Weight: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let thin         = Weight(rawValue: 100)
        public static let ultraLight   = Weight(rawValue: 200)
        public static let light        = Weight(rawValue: 300)
        public static let regular      = Weight(rawValue: 400)
        public static let medium       = Weight(rawValue: 500)
        public static let semibold     = Weight(rawValue: 600)
        public static let bold         = Weight(rawValue: 700)
        public static let black        = Weight(rawValue: 900)
        
    }
    
}
