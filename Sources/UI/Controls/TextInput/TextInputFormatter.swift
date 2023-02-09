import Foundation

public protocol TextInputFormatter {
    
    func process(originalString: String, appending appendedString: String) -> String
    
}

extension TextInputFormatter {
    
    func makeString(originalString: String, usingTemplate templateString: String, templateSymbol: Character) -> String {
        var result = ""
        
        var nextOriginalStringIndex = originalString.startIndex
        var nextTemplateStringIndex = templateString.startIndex
        
        while nextOriginalStringIndex < originalString.endIndex && nextTemplateStringIndex < templateString.endIndex {
            if templateString[nextTemplateStringIndex] == templateSymbol {
                result.append(originalString[nextOriginalStringIndex])
                nextOriginalStringIndex = originalString.index(after: nextOriginalStringIndex)
            } else {
                result.append(templateString[nextTemplateStringIndex])
            }
            
            nextTemplateStringIndex = templateString.index(after: nextTemplateStringIndex)
        }
        
        return result
    }
    
}
