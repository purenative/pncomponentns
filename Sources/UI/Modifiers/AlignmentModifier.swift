import SwiftUI

public struct AlignmentModifier: ViewModifier {
    
    let alignment: Alignment
    
    public init(alignment: Alignment) {
        self.alignment = alignment
    }
    
    public func body(content: Content) -> some View {
        switch alignment {
        case .leading:
            HStack(spacing: 0) {
                content
                Spacer()
            }
            
        case .top:
            VStack(spacing: 0) {
                content
                Spacer()
            }
            
        case .trailing:
            HStack(spacing: 0) {
                Spacer()
                content
            }
            
        case .bottom:
            VStack(spacing: 0) {
                Spacer()
                content
            }
            
        case .topLeading:
            content
                .modifier(AlignmentModifier(alignment: .top))
                .modifier(AlignmentModifier(alignment: .leading))
            
        case .topTrailing:
            content
                .modifier(AlignmentModifier(alignment: .top))
                .modifier(AlignmentModifier(alignment: .trailing))
            
        case .bottomTrailing:
            content
                .modifier(AlignmentModifier(alignment: .bottom))
                .modifier(AlignmentModifier(alignment: .trailing))
            
        case .bottomLeading:
            content
                .modifier(AlignmentModifier(alignment: .bottom))
                .modifier(AlignmentModifier(alignment: .leading))
            
        case .center:
            ZStack(alignment: .center) {
                content
            }
            
        default:
            content
        }
    }
    
}

extension View {
    
    public func alignment(_ alignment: Alignment) -> some View {
        modifier(AlignmentModifier(alignment: alignment))
    }
    
}
