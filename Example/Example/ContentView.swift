import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Example.allCases) { example in
                    NavigationLink(destination: example.body) {
                        Text(example.name)
                    }
                }
            }
        }
    }
}
