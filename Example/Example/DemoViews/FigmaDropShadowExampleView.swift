import SwiftUI

struct FigmaDropShadowExampleView: View {
    
    let shadowColor = Color.black.opacity(0.13)
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                buildTestView(text: "Default shadow")
                    .shadow(color: shadowColor, radius: 10, x: 0, y: 4)
                
                buildTestView(text: "Figma.App shadow")
                    .dropShadow(color: shadowColor, blur: 10, spread: 0, x: 0, y: 4)
                
                Spacer()
            }
            .padding(24)
        }
    }
    
    @ViewBuilder
    private func buildTestView(text: String) -> some View {
        ZStack {
            Color.white
            
            Text(text)
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
        .frame(height: 50)
        .cornerRadius(8)
    }
    
}

struct FigmaDropShadowExampleView_Previews: PreviewProvider {
    static var previews: some View {
        FigmaDropShadowExampleView()
    }
}
