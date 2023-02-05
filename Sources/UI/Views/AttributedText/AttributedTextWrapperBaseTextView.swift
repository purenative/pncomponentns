import Foundation
import UIKit

final class AttributedTextWrapperBaseTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .clear
        
        isEditable = false
        isScrollEnabled = false
        isSelectable = true
        
        textContainerInset = .zero
        textContainer?.lineFragmentPadding = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var maxLayoutWidth: CGFloat = 0 {
        didSet {
            guard maxLayoutWidth != oldValue else {
                return
            }
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        guard maxLayoutWidth > 0 else {
            return super.intrinsicContentSize
        }

        let sizeToFit = CGSize(
            width: maxLayoutWidth,
            height: .greatestFiniteMagnitude
        )
        return sizeThatFits(sizeToFit)
    }
    
}
