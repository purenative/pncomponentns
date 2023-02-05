import Foundation
import SwiftUI

final class AttributedTextWrapperBaseTextViewStore: ObservableObject {
    
    @Published
    private(set) var height: CGFloat?
        
    func didUpdate(textView: AttributedTextWrapperBaseTextView) {
        let intrinsicContentSize = textView.intrinsicContentSize
        
        DispatchQueue.main.async { [weak self] in
            self?.height = intrinsicContentSize.height
        }
    }
    
}
