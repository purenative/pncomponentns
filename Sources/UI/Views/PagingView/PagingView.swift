import SwiftUI

public struct PagingView<Page: View, Item: PageContent>: UIViewControllerRepresentable {
    
    let looped: Bool
    
    @Binding
    var currentPageIndex: Int
    
    let items: [Item]
    let pageContentBuilder: (Item) -> Page
    
    public init(looped: Bool = false, currentPageIndex: Binding<Int> = .constant(0), items: [Item], @ViewBuilder pageContentBuilder: @escaping (Item) -> Page) {
        self.looped = looped
        _currentPageIndex = currentPageIndex
        self.items = items
        self.pageContentBuilder = pageContentBuilder
    }
    
    public func makeUIViewController(context: Context) -> PagingViewBaseController<Page> {
        let pagingViewController = PagingViewBaseController<Page>(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pagingViewController.looped = looped
        
        let pages = items.map(pageContentBuilder)
        pagingViewController.setPages(pages)
        
        pagingViewController.onPageIndexChanged = { index in
            currentPageIndex = index
        }
        
        return pagingViewController
    }
    
    public func updateUIViewController(_ pagingViewController: PagingViewBaseController<Page>, context: Context) {
        
    }
    
}
