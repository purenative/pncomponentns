import SwiftUI
import Foundation
import PNComponents

struct SegmentControlExampleView: View {
    
    @State
    var gender: Gender = .male
    
    var body: some View {
        VStack(spacing: 24) {
            SegmentControl(
                items: Gender.allCases,
                selectedItem: $gender.animation(),
                itemViewBuilder: buildGenderSegmentItemView(gender:selected:),
                selectorViewBuilder: buildSegmentControlSelector
            )
            .background(
                Color.gray.opacity(0.2)
                    .cornerRadius(10)
            )
            .frame(height: 42)
            
            Text("Selected gender: \(gender.title)")
                .alignment(.leading)
            
            Spacer()
        }
        .padding(24)
    }
    
    @ViewBuilder
    private func buildGenderSegmentItemView(gender: Gender, selected: Bool) -> some View {
        ZStack {
            Color.white.opacity(0.01)
            
            Text(gender.title)
                .fontWeight(selected ? .bold : .semibold)
                .foregroundColor(.black)
        }
        .cornerRadius(8)
        .padding(2)
        .animation(nil)
    }
    
    @ViewBuilder
    private func buildSegmentControlSelector() -> some View {
        Color.white
            .cornerRadius(8)
            .padding(2)
    }
    
}

enum Gender: String, CaseIterable, SegmentControlItem {
    
    case male = "Male"
    case female = "Female"
    
    var title: String {
        rawValue
    }
    
    var id: String {
        rawValue
    }
    
}

struct SegmentControlExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControlExampleView()
    }
}
