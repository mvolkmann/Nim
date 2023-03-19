import SwiftUI

struct Nim: View {
    private let tabSize = 40.0

    @State private var computerWon = false
    @State private var gameStarted = false
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
        gameStarted = true
        rows[row] -= count
        if gameOver { computerWon = byHuman }
    }

    private func resetGame() {
        gameStarted = false
        computerWon = false
        rows = [7, 5, 3]
    }

    private func score(_ rows: [Int]) -> Int {
        // We are in the end game if all rows are empty or contain one.
        let isEndGame = rows.allSatisfy { count in count <= 1 }
        if isEndGame {
            let total = rows.reduce(0, +)
            // Score is 1 for an even total and 0 for an odd total.
            return total % 2 == 0 ? 1 : 0
        }
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

            if !gameStarted {
                Button("Make computer goes first.") { makeMove() }
            }

            if gameOver {
                Text((computerWon ? "The computer" : "You") + " won!")
                    .font(.title)
                Button("New Game") {
                    resetGame()
                }.buttonStyle(.borderedProminent)
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
