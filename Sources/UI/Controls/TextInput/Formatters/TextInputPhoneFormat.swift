import Foundation

struct TextInputPhoneFormat: TextInputFormatter {
    
    static let DIGIT_SYMBOL: Character = "d"
    
    let code: String
    let format: String
    
    func process(originalString: String, appending appendedString: String) -> String {
        var cleanString = originalString.digitsOnly
        
        if appendedString.isEmpty {
            if !cleanString.isEmpty {
                _ = cleanString.removeLast()
            }
        } else {
            cleanString.append(appendedString)
        }
        
        if !code.isEmpty {
            let cleanCode = code.digitsOnly
            if cleanString.starts(with: cleanCode) {
                for _ in 0..<cleanCode.count {
                    cleanString.removeFirst()
                }
            }
        }
        
        return makeString(
            originalString: cleanString,
            usingTemplate: format,
            templateSymbol: Self.DIGIT_SYMBOL
        )
    }
    
}
