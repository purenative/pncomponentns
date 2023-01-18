import SwiftUI

struct AlignmentExampleView: View {
    
    var body: some View {
        ZStack {
            Text("Top Leading")
                .alignment(.topLeading)
            
            Text("Center")
                .alignment(.center)
            
            Text("Bottom Trailing")
                .alignment(.bottomTrailing)
        }
        .padding()
    }
    
}

struct AlignmentExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentExampleView()
    }
}
