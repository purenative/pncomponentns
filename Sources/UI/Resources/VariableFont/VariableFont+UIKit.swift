import UIKit

public extension UIFont {
    
    convenience init(variableFont: VariableFont) {
        let variations = [
            VariableFont.WEIGHT_KEY: variableFont.weight.rawValue,
            VariableFont.WIDTH_KEY: variableFont.width.rawValue
        ]
        
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            .name: variableFont.name,
            kCTFontVariationAttribute as UIFontDescriptor.AttributeName: variations
        ])
        
        self.init(
            descriptor: fontDescriptor,
            size: variableFont.size
        )
    }
    
}
