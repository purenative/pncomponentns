//
//  CornerRadiusExampleView.swift
//  Example Application
//
//  Created by Artem Eremeev on 06.08.2023.
//

import SwiftUI
import PNComponents

struct CornerRadiusExampleView: View {
    
    var body: some View {
        
        let corners = [RectCorner.topLeft, .topRight, .bottomLeft, .bottomRight, .allCorners]
        
        VStack(spacing: 24) {
            ForEach(corners, id: \.rawValue) { corner in
                Color.orange
                    .frame(width: 200, height: 80)
                    .cornerRadius(40, corners: corner)
            }
        }
        .padding(24)
    }
    
}

struct CornerRadiusExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CornerRadiusExampleView()
    }
}
