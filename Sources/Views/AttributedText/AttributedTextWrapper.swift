import SwiftUI
import UIKit

struct AttributedTextWrapper: UIViewRepresentable {
    
    typealias OnLinkTapped = AttributedTextWrapperCoordinator.OnLinkTapped
    
    @Binding
    var attributedString: NSAttributedString
    
    let linkTextAttributes: [NSAttributedString.Key: Any]?
    
    var onLinkTapped: OnLinkTapped? = nil
    
    let store: AttributedTextWrapperBaseTextViewStore
    let maxLayoutWidth: CGFloat
    
    func makeUIView(context: Context) -> AttributedTextWrapperBaseTextView {
        let textView = AttributedTextWrapperBaseTextView(frame: .zero)
        
        textView.attributedText = attributedString
        textView.linkTextAttributes = linkTextAttributes
        
        context.coordinator.bind(textView: textView)
        
        return textView
    }
    
    func updateUIView(_ textView: AttributedTextWrapperBaseTextView, context: Context) {
        textView.attributedText = attributedString
        textView.maxLayoutWidth = maxLayoutWidth
        store.didUpdate(textView: textView)
    }
    
    func makeCoordinator() -> AttributedTextWrapperCoordinator {
        AttributedTextWrapperCoordinator(onLinkTapped: onLinkTapped)
    }
    
}
