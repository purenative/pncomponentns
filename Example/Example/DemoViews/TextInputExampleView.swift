import SwiftUI
import PNComponents

struct TextInputExampleView: View {
    
    @State
    var phone: String = ""
    
    @State
    var text: String = ""
    
    @State
    var note: String = ""
    
    @State
    var noteFocused = false
    
    var body: some View {
        VStack {
            TextInput(
                text: $phone,
                formatter: TextInput.phone(code: "+7", format: "+7(ddd)ddd-dd-dd"),
                configuration: {
                    $0.keyboardType = .phonePad
                    $0.placeholder = "Type phone here"
                },
                withDoneButton: true
            )
            .frame(height: 50)
            
            TextInput(
                text: $text,
                configuration: { $0.placeholder = "Type text here" },
                withDoneButton: false
            )
            .frame(height: 50)
            
            TextInput(
                text: $note,
                focused: $noteFocused,
                configuration: { $0.placeholder = "Type note..." },
                withDoneButton: true
            )
            .frame(height: 50)
            
            Toggle(
                "Note focused",
                isOn: $noteFocused
            )
            .frame(height: 50)
            
            Spacer()
        }
        .padding()
    }
    
}

struct TextInputExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputExampleView()
    }
}
