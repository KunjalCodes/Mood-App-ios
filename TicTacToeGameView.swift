import SwiftUI

struct TicTacToeGameView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var gameOver = false
    @State private var winner: String? = nil

    let winningCombinations: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
        [0, 4, 8], [2, 4, 6]             // Diagonals
    ]

    var body: some View {
        VStack {
            Text("Tic-Tac-Toe vs Computer")
                .font(.largeTitle)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                ForEach(0..<9) { i in
                    Button(action: {
                        if board[i] == "" && !gameOver && currentPlayer == "X" {
                            board[i] = currentPlayer
                            checkForWinner()
                            currentPlayer = "O"
                            computerMove()
                        }
                    }) {
                        Text(board[i])
                            .font(.system(size: 40))
                            .frame(width: 100, height: 100)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                }
            }
            .padding()

            if gameOver {
                Text(winner != nil ? "\(winner!) wins!" : "It's a draw!")
                    .font(.title)
                    .padding()

                Button("Play Again") {
                    resetGame()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }

    // Computer makes a random move
    func computerMove() {
        if !gameOver {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Adds a small delay
                let availableMoves = board.indices.filter { board[$0] == "" }
                if let randomMove = availableMoves.randomElement() {
                    board[randomMove] = "O"
                    checkForWinner()
                    currentPlayer = "X"
                }
            }
        }
    }

    func checkForWinner() {
        for combo in winningCombinations {
            if board[combo[0]] != "" && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] {
                winner = board[combo[0]]
                gameOver = true
                return
            }
        }

        if !board.contains("") {
            gameOver = true
        }
    }

    func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        gameOver = false
        winner = nil
    }
}
