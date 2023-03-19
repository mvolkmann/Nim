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

    private func score(rows: [Int]) -> Int {
        let sortedRows = rows.sorted()
        if sortedRows == [0, 1, 1] { return 1 } // not winning
        if sortedRows == [1, 1, 1] { return 0 } // winning
        if sortedRows == [0, 0, 1] { return 0 } // winning

        /*
         var result = 0
         for row in rows {
             result ^= row
         }
         return result
         */
        return rows.reduce(0) { acc, count in acc ^ count }
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
            } else {
                Text("Score = \(score(rows: rows))")
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
