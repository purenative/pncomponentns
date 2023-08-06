//
//  CountdownExampleView.swift
//  Example Application
//
//  Created by Artem Eremeev on 06.08.2023.
//

import SwiftUI
import PNComponents

class CountdownExampleState: ObservableObject {
    
    private let countdown = Countdown()
    
    @Published
    var count: TimeInterval = 0.0
    
    init() {
        countdown.$count.assign(to: &$count)
    }
    
    func start() {
        countdown.stop()
        countdown.start(count: 10)
    }
    
}

struct CountdownExampleView: View {
    
    @StateObject
    var state = CountdownExampleState()
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            if state.count.isZero {
                Text("Start")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.green)
                    .buttonAction({
                        state.start()
                    })
            } else {
                Text(String(state.count))
                    .font(.system(size: 24, weight: .semibold))
                
                Text("Restart")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.orange)
                    .buttonAction({
                        state.start()
                    })
            }
            
            Spacer()
        }
        .padding()
    }
    
}

struct CountdownExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownExampleView()
    }
}
