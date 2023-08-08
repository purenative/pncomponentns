import SwiftUI

public struct SegmentControl<Item: SegmentControlItem, ItemView: View, SelectorView: View>: View {
    
    let spacing: CGFloat
    
    let items: [Item]
    @Binding
    var selectedItem: Item
    let itemViewBuilder: (Item, Bool) -> ItemView
    let selectorViewBuilder: () -> SelectorView
    
    public init(spacing: CGFloat = .zero, items: [Item], selectedItem: Binding<Item>, @ViewBuilder itemViewBuilder: @escaping (Item, Bool) -> ItemView, @ViewBuilder selectorViewBuilder: @escaping () -> SelectorView) {
        self.spacing = spacing
        self.items = items
        self._selectedItem = selectedItem
        self.itemViewBuilder = itemViewBuilder
        self.selectorViewBuilder = selectorViewBuilder
    }
    
    public init(spacing: CGFloat = .zero, items: [Item], selectedItem: Binding<Item>, @ViewBuilder itemViewBuilder: @escaping (Item, Bool) -> ItemView) where SelectorView == EmptyView {
        self.spacing = spacing
        self.items = items
        self._selectedItem = selectedItem
        self.itemViewBuilder = itemViewBuilder
        self.selectorViewBuilder = { EmptyView() }
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                let itemWidth = (geometry.size.width - CGFloat(items.count - 1) * spacing) / CGFloat(items.count)
                let selectedItemIndex = items.firstIndex(where: { $0.id == selectedItem.id }) ?? 0
                let selectorXOffset = CGFloat(selectedItemIndex) * (itemWidth + spacing)
                
                selectorViewBuilder()
                    .frame(width: itemWidth)
                    .offset(x: selectorXOffset)
                
                HStack(alignment: .center, spacing: spacing) {
                    ForEach(items) { item in
                        itemViewBuilder(item, item.id == selectedItem.id)
                            .frame(width: itemWidth)
                            .buttonAction({ selectedItem = item })
                    }
                }
            }
        }
        
    }
    
}
