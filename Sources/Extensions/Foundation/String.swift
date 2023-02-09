import Foundation

public extension String {
    
    static var empty: String {
        ""
    }
    
    var digitsOnly: String {
        filter("1234567890".contains)
    }
    
}
