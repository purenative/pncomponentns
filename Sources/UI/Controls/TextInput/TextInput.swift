import SwiftUI

public struct TextInput: View {
    
    public typealias Configuration = (UITextField) -> Void
    
    @Binding
    var text: String
    
    let formatter: TextInputFormatter?
    let configuration: Configuration
    let withDoneButton: Bool
    
    public init(text: Binding<String>, configuration: Configuration? = nil, withDoneButton: Bool = true) {
        _text = text
        self.formatter = nil
        self.configuration = configuration ?? { _ in }
        self.withDoneButton = withDoneButton
    }
    
    public init(text: Binding<String>, formatter: TextInputFormatter, configuration: Configuration? = nil, withDoneButton: Bool = true) {
        _text = text
        self.formatter = formatter
        self.configuration = configuration ?? { _ in }
        self.withDoneButton = withDoneButton
    }
    
    public var body: some View {
        TextInputWrapper(
            text: $text,
            formatter: formatter,
            configuration: configuration,
            withDoneButton: withDoneButton
        )
    }
}

#if DEBUG
struct TextInput_Previews: PreviewProvider {
    
    @State
    static var text: String = ""
    
    static var previews: some View {
        TextInput(
            text: $text,
            formatter: TextInput.phone(code: "+7", format: "(ddd)ddd-dd-dd"),
            configuration: { $0.placeholder = "Type here..." }
        )
    }
}
#endif
