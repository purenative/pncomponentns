import SwiftUI
import PNComponents

/// Button action modifier makes transform any view to button.
/// Use buttonAction extension for easy access to modifier implementation.
struct ButtonActionExampleView: View {
    
    @State
    var count: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
            
            Spacer(minLength: 24)
            
            HStack(spacing: 10) {
                Image(systemName: "apple.logo")
                
                Text("Increase count")
            }
            .buttonAction({
                count += 1
            })
            
            Spacer()
        }
        .padding()
    }
    
}

struct ButtonActionExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActionExampleView()
    }
}
