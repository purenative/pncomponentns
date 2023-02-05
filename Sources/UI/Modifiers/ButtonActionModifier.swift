import SwiftUI

/// Wraps any view into button.
public struct ButtonActionModifier<ButtonStyle: PrimitiveButtonStyle>: ViewModifier {
    
    let buttonStyle: ButtonStyle
    let action: () -> Void
    
    public init(buttonStyle: ButtonStyle, action: @escaping () -> Void) {
        self.buttonStyle = buttonStyle
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        Button(action: action) {
            content
        }
        .buttonStyle(buttonStyle)
    }
    
}

extension View {
    
    /// Wraps view into button
    public func buttonAction(_ action: @escaping () -> Void) -> some View {
        modifier(
            ButtonActionModifier(
                buttonStyle: PlainButtonStyle(),
                action: action
            )
        )
    }
    
    /// Wraps view into button with button style
    public func buttonAction<ButtonStyle: PrimitiveButtonStyle>(buttonStyle: ButtonStyle, _ action: @escaping () -> Void) -> some View {
        modifier(
            ButtonActionModifier(
                buttonStyle: buttonStyle,
                action: action
            )
        )
    }
    
}
