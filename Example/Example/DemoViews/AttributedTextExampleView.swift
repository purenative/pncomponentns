import SwiftUI
import PNComponents

struct AttributedTextExampleView: View {
    
    @State
    var attributedString = NSAttributedString(string: "Hello!\nThis is a test text", attributes: [
        .font: UIFont.systemFont(ofSize: 20, weight: .bold),
        .foregroundColor: UIColor.systemOrange
    ])
    
    var body: some View {
        ZStack {
            AttributedText(attributedString: $attributedString)
                .padding(24)
        }
    }
    
}

#if DEBUG
struct AttributedTextExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AttributedTextExampleView()
    }
}
#endif
