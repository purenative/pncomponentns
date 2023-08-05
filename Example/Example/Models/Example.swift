import Foundation
import SwiftUI

enum Example: String, Identifiable, CaseIterable {
    
    case buttonAction = "Button Action"
    case alignment = "Alignment"
    case segmentControl = "Segment Control"
    case dropShadow = "Drop Shadow"
    case attributedText = "Attributed Text"
    case textInput = "Text Input"
    case pagingView = "Paging View"
    case cameraPreview = "Camera Preview"
    case cornerRadius = "Corner Radius"
    
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
            
        case .alignment:
            AlignmentExampleView()
            
        case .segmentControl:
            SegmentControlExampleView()
            
        case .dropShadow:
            FigmaDropShadowExampleView()
            
        case .attributedText:
            AttributedTextExampleView()
            
        case .textInput:
            TextInputExampleView()
            
        case .pagingView:
            PagingViewExampleView()
            
        case .cameraPreview:
            CameraPreviewExampleView()
            
        case .cornerRadius:
            CornerRadiusExampleView()
        }
    }
    
}
