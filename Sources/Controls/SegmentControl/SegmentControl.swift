import SwiftUI

public struct SegmentControl<Item: SegmentControlItem, ItemView: View>: View {
    
    let spacing: CGFloat
    
    let items: [Item]
    @Binding
    var selectedItem: Item
    let itemViewBuilder: (Item, Bool) -> ItemView
    
    public init(spacing: CGFloat = .zero, items: [Item], selectedItem: Binding<Item>, @ViewBuilder itemViewBuilder: @escaping (Item, Bool) -> ItemView) {
        self.spacing = spacing
        self.items = items
        self._selectedItem = selectedItem
        self.itemViewBuilder = itemViewBuilder
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                let itemWidth = (geometry.size.width - CGFloat(items.count - 1) * spacing) / CGFloat(items.count)
                
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
