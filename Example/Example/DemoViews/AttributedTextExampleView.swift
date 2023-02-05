import SwiftUI
import PNComponents

struct AttributedTextExampleView: View {
    
    @State
    var attributedString = Self.createAttributedString()
    
    var body: some View {
        ZStack {
            AttributedText(attributedString: $attributedString)
                .padding(24)
        }
    }
    
    private static func createAttributedString() -> NSAttributedString {
        NSMutableAttributedString()
            .appending(string: "Hello", with: [
                .font: UIFont.systemFont(ofSize: 30, weight: .bold),
                .foregroundColor: UIColor.systemRed
            ])
            .appending(string: "\n\n")
            .appending(string: "This is a test text", with: [
                .font: UIFont.systemFont(ofSize: 20),
                .foregroundColor: UIColor.systemOrange
            ])
            .appending(string: "\n")
            .appending(string: "Just for example", with: [
                .foregroundColor: UIColor.systemYellow
            ])
            .adding(attributes: [
                .font: UIFont.systemFont(ofSize: 30, weight: .bold),
                .foregroundColor: UIColor.systemBlue
            ], for: "test")
    }
    
}

#if DEBUG
struct AttributedTextExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AttributedTextExampleView()
    }
}
#endif
