import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Nim")
                .font(.largeTitle)
                .padding(.bottom)
            Text("""
            Take turns clicking squares to remove it
            and all squares to its right in the same row.
            The computer will do the same.
            The player that removes the last square loses.
            """)
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
