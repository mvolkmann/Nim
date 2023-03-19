import SwiftUI

struct Nim: View {
    private let tabSize = 40.0

    @State private var rows = [3, 5, 7]

    private var gameOver: Bool {
        rows.allSatisfy { count in count == 0 }
    }

    private func removeTabs(row: Int, count: Int) {
        rows[row] = count - 1
    }

    var body: some View {
        VStack {
            ForEach(Array(rows.enumerated()), id: \.offset) { index, count in
                if index > 0 {
                    Divider().overlay(.black)
                }
                HStack {
                    if count == 0 {
                        Color.clear
                            .frame(width: tabSize, height: tabSize)
                    } else {
                        ForEach(1 ... count, id: \.self) { n in
                            Button(
                                action: { removeTabs(row: index, count: n) },
                                label: {
                                    Color.pink
                                        .frame(width: tabSize, height: tabSize)
                                }
                            )
                        }
                    }
                    Spacer()
                }
            }

            if gameOver {
                Text("Game Over!").font(.title)
            }

            Spacer()
        }
    }
}

struct Nim_Previews: PreviewProvider {
    static var previews: some View {
        Nim()
    }
}
