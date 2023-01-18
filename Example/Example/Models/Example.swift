import Foundation
import SwiftUI

enum Example: String, Identifiable, CaseIterable {
    
    case buttonAction = "Button Action"
    
    var id: String {
        rawValue
    }
    
    var name: String {
        rawValue
    }
    
    @ViewBuilder
    func body() -> some View {
        switch self {
        case .buttonAction:
            ButtonActionExampleView()
            
        }
    }
    
}