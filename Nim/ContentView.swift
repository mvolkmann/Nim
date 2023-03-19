import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Nim").font(.largeTitle)
            Nim()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
