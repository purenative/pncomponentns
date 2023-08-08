import SwiftUI
import UIKit

struct TextInputWrapper: UIViewRepresentable {
    
    typealias Configuration = (UITextField) -> Void
    
    @Binding
    var text: String
    
    let focused: Binding<Bool>?
    
    let formatter: TextInputFormatter?
    let configuration: Configuration
    let withDoneButton: Bool
    
    init(text: Binding<String>, focused: Binding<Bool>? = nil, formatter: TextInputFormatter? = nil, configuration: Configuration? = nil, withDoneButton: Bool = true) {
        _text = text
        self.focused = focused
        self.formatter = formatter
        self.configuration = configuration ?? { _ in }
        self.withDoneButton = withDoneButton
    }
    
    func makeUIView(context: Context) -> TextInputWrapperBaseTextField {
        let textField = TextInputWrapperBaseTextField(configuration: configuration)
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        context.coordinator.bind(textField: textField)
        textField.text = text
        
        if withDoneButton {
            textField.addDoneButton()
        }
        
        return textField
    }
    
    func updateUIView(_ textField: TextInputWrapperBaseTextField, context: Context) {
        context.coordinator.updateTextIfNeeded(text)
        
        if let focused = focused?.wrappedValue {
            context.coordinator.updateFocusedIfNeeded(focused)
        }
    }
    
    func makeCoordinator() -> TextInputWrapperCoordinator {
        TextInputWrapperCoordinator(
            text: $text,
            formatter: formatter,
            onFocusChanged: { focused?.wrappedValue = $0 }
        )
    }
    
}
