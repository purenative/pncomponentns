import SwiftUI
import PNComponents

struct PagingViewExampleView: View {
    
    @State
    var currentPageIndex: Int = 0
    
    var body: some View {
        ZStack {
            PagingView(
                looped: true,
                currentPageIndex: $currentPageIndex,
                items: ColoredPage.allCases,
                pageContentBuilder: buildPageView
            )
            .ignoresSafeArea()
            
            Text("Current page index\n\(currentPageIndex)")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .allowsHitTesting(false)
        }
    }
    
    @ViewBuilder
    private func buildPageView(_ coloredPage: ColoredPage) -> some View {
        switch coloredPage {
        case .red:
            Color.red
                .ignoresSafeArea()
            
        case .green:
            Color.green
                .ignoresSafeArea()
            
        case .blue:
            Color.blue
                .ignoresSafeArea()
        }
    }
    
}

enum ColoredPage: PageContent, CaseIterable {
    
    case red
    case green
    case blue
    
}

#if DEBUG
struct PagingViewExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PagingViewExampleView()
    }
}
#endif
