import Foundation
import CoreText

public struct VariableFont {
    
    static let WEIGHT_KEY = 2_003_265_652
    static let WIDTH_KEY = 2_003_072_104
    
    let name: String
    let size: CGFloat
    private(set) var weight: Weight
    let width: Width
    
    var font: CTFont {
        createCoreTextFont()
    }
    
    public init(name: String, size: CGFloat, weight: Weight, width: Width = .standard) {
        
        self.name = name
        self.size = size
        self.weight = weight
        self.width = width
        
        prepareFontWeightLimits()
    }
    
    private mutating func prepareFontWeightLimits() {
        let font = createCoreTextFont()
        let info = (CTFontCopyVariationAxes(font) as NSArray?)?.firstObject as? NSDictionary
        
        if let info, let identifier = info.object(forKey: kCTFontVariationAxisIdentifierKey) as? NSNumber, identifier.intValue == VariableFont.WEIGHT_KEY {
            if let minimumValue = info.object(forKey: kCTFontVariationAxisMinimumValueKey) as? NSNumber, let maximumValue = info.object(forKey: kCTFontVariationAxisMaximumValueKey) as? NSNumber {
                weight = Weight(rawValue: max(minimumValue.intValue, min(maximumValue.intValue, weight.rawValue)))
            }
        }
    }
    
    private func createCoreTextFont() -> CTFont {
        let variations = [
            VariableFont.WEIGHT_KEY: weight.rawValue,
            VariableFont.WIDTH_KEY: width.rawValue
        ]
        
        let attributes = [
            kCTFontVariationAttribute: variations,
            kCTFontNameAttribute: name as CFString
        ] as CFDictionary
        
        let descriptor = CTFontDescriptorCreateWithAttributes(attributes)
        
        return CTFont(descriptor, size: size)
    }
    
}
