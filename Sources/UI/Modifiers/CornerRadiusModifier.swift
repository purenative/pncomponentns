import UIKit
import SwiftUI

public struct RectCorner: OptionSet {
    
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
}

public extension RectCorner {
    
    static let topLeft = RectCorner(rawValue: UIRectCorner.topLeft.rawValue)
    static let topRight = RectCorner(rawValue: UIRectCorner.topRight.rawValue)
    static let bottomLeft = RectCorner(rawValue: UIRectCorner.bottomLeft.rawValue)
    static let bottomRight = RectCorner(rawValue: UIRectCorner.bottomRight.rawValue)
    static let allCorners = RectCorner(rawValue: UIRectCorner.allCorners.rawValue)
    
}

struct CornerRoundedRectangle: Shape {
    
    let radius: CGFloat
    let corners: RectCorner
    
    func path(in rect: CGRect) -> Path {
        let corners = UIRectCorner(rawValue: corners.rawValue)
        let bezierPath = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(bezierPath.cgPath)
    }
    
}

public struct CornerRadiusModifier: ViewModifier {
    
    let radius: CGFloat
    let corners: RectCorner
    
    public init(radius: CGFloat, corners: RectCorner) {
        self.radius = radius
        self.corners = corners
    }
    
    public func body(content: Content) -> some View {
        content.clipShape(
            CornerRoundedRectangle(
                radius: radius,
                corners: corners
            )
        )
    }
    
}

public extension View {
    
    /// Applies corner radius
    func cornerRadius(_ radius: CGFloat, corners: RectCorner) -> some View {
        modifier(
            CornerRadiusModifier(
                radius: radius,
                corners: corners
            )
        )
    }
    
}
