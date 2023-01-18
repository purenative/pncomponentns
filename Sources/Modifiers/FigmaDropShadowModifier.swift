import CoreGraphics
import SwiftUI

public struct FigmaDropShadowModifier: ViewModifier {
    
    let color: Color
    let blur: CGFloat
    let spread: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    public init(color: Color, blur: CGFloat, spread: CGFloat, x: CGFloat, y: CGFloat) {
        self.color = color
        self.blur = blur
        self.spread = spread
        self.x = x
        self.y = y
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                color
                    .padding(-spread / 2)
                    .offset(x: x, y: y)
                    .blur(radius: blur)
            )
    }
    
}

extension View {
    
    /// Applies Drop Shadow using parameters from Figma.App
    public func dropShadow(color: Color, blur: CGFloat, spread: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        modifier(
            FigmaDropShadowModifier(
                color: color,
                blur: blur,
                spread: spread,
                x: x,
                y: y
            )
        )
    }
    
}
