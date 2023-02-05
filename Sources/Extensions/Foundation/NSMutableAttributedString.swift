import Foundation

public extension NSMutableAttributedString {
    
    func append(string: String) {
        mutableString.append(string)
    }
    
    func appending(string: String) -> NSMutableAttributedString {
        append(string: string)
        return self
    }
    
    func append(string: String, with attributes: [NSAttributedString.Key: Any]) {
        let originalOffset = mutableString.length
        
        mutableString.append(string)
        
        let range = NSRange(location: originalOffset, length: string.count)
        addAttributes(attributes, range: range)
    }
    
    func appending(string: String, with attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        append(string: string, with: attributes)
        return self
    }
    
    func add(attributes: [NSAttributedString.Key: Any], for string: String) {
        guard mutableString.length > 0 else {
            return
        }
        
        var location = 0
        
        while location < mutableString.length {
            let searchRange = NSRange(location: location, length: mutableString.length - location)
            
            let resultRange = mutableString.range(of: string, range: searchRange)
            
            if resultRange.location == NSNotFound {
                break
            }
            
            addAttributes(attributes, range: resultRange)
            
            location = resultRange.location + resultRange.length
        }
    }
    
    func adding(attributes: [NSAttributedString.Key: Any], for string: String) -> NSMutableAttributedString {
        add(attributes: attributes, for: string)
        return self
    }
    
}
