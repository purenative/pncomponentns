import Foundation
import UIKit

class AttributedTextWrapperCoordinator: NSObject {
    
    typealias OnLinkTapped = (URL) -> Void
    
    private weak var textView: UITextView?
    
    private let onLinkTapped: OnLinkTapped?

    init(onLinkTapped: OnLinkTapped?) {
        self.onLinkTapped = onLinkTapped
    }
    
    func bind(textView: UITextView) {
        self.textView = textView
        textView.delegate = self
    }
    
}

extension AttributedTextWrapperCoordinator: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if let onLinkTapped = onLinkTapped {
            onLinkTapped(URL)
            return false
        }
        
        return true
    }
    
}
