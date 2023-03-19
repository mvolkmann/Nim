import SwiftUI

struct Nim: View {
    private let tabSize = 40.0

    @State private var computerWon = false
    @State private var rows = [7, 5, 3]

    private var gameOver: Bool {
        rows.allSatisfy { count in count == 0 }
    }

    private func makeMove() {
        guard !gameOver else { return }

        var foundMove = false

        // Find the first move that results in a score of zero.
        for (index, count) in rows.enumerated() {
            if count == 0 { continue }

            let options = Array(1 ... count)
            for count in options {
                var board = rows
                board[index] -= count
                if score(board) == 0 {
                    // print("Computer is removing \(count) from row \(index + 1)")
                    removeTabs(row: index, count: count)
                    foundMove = true
                    break
                }
            }

            if foundMove { break }
        }

        if !foundMove {
            // Just remove one from any non-empty row.
            for (index, count) in rows.enumerated() {
                if count > 0 {
                    // print("Computer is removing 1 from row \(index + 1)")
                    removeTabs(row: index, count: 1)
                    break
                }
            }
        }
    }

    private func removeTabs(row: Int, count: Int, byHuman: Bool = false) {
        rows[row] -= count
        if gameOver { computerWon = byHuman }
    }

    private func score(_ rows: [Int]) -> Int {
        let sortedRows = rows.sorted()
        if sortedRows == [1, 1, 1] { return 0 } // winning
        if sortedRows == [0, 1, 1] { return 1 } // not winning
        if sortedRows == [0, 0, 1] { return 0 } // winning
        return rows.reduce(0) { acc, count in acc ^ count }
    }

    var body: some View {
        VStack {
            Button("Computer Goes First") { makeMove() }

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
                                action: {
                                    removeTabs(
                                        row: index,
                                        count: rows[index] - n + 1,
                                        byHuman: true
                                    )
                                    makeMove()
                                },
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
                Text("Game Over").font(.title)
                Text((computerWon ? "The computer" : "You") + " won!")
                    .font(.headline)
            } else {
                Text("Score = \(score(rows))")
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
