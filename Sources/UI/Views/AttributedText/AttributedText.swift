import SwiftUI

public struct AttributedText: View {
    
    public typealias OnLinkTapped = (URL) -> Void
    
    @StateObject
    var store = AttributedTextWrapperBaseTextViewStore()
    
    @Binding
    var attributedString: NSAttributedString
    
    let linkTextAttributes: [NSAttributedString.Key: Any]?
    let onLinkTapped: OnLinkTapped?
    
    public init(attributedString: Binding<NSAttributedString>, linkTextAttributes: [NSAttributedString.Key: Any]? = nil, onLinkTapped: OnLinkTapped? = nil) {
        
        _attributedString = attributedString
        self.linkTextAttributes = linkTextAttributes
        self.onLinkTapped = onLinkTapped
    }
    
    public var body: some View {
        GeometryReader<AnyView> { geometry in
            let maxLayoutWidth = geometry.size.width - geometry.safeAreaInsets.leading - geometry.safeAreaInsets.trailing
            
            AnyView(
                AttributedTextWrapper(
                    attributedString: $attributedString,
                    linkTextAttributes: linkTextAttributes,
                    onLinkTapped: onLinkTapped,
                    store: store,
                    maxLayoutWidth: maxLayoutWidth
                )
            )
        }
        .frame(height: store.height)
    }
}

#if DEBUG
struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText(attributedString: .constant(.init()))
    }
}
#endif
