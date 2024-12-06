import SwiftUI

struct SnakeAndLadderView: View {
    @State private var playerPosition = 0
    @State private var computerPosition = 0
    @State private var currentPlayer: Player = .human
    @State private var message = "Your turn!"
    @State private var diceValue = 1
    
    let winningPosition = 30 // The final position to win
    let snakes: [Int: Int] = [16: 6, 47: 26, 49: 11, 56: 53, 62: 19, 64: 60, 87: 24, 93: 73, 95: 75, 98: 78]
    let ladders: [Int: Int] = [1: 38, 4: 14, 9: 31, 21: 42, 28: 84, 36: 44, 51: 67, 71: 91, 80: 100]

    enum Player {
        case human, computer
    }
    
    var body: some View {
        VStack {
            Text("Snake and Ladder")
                .font(.largeTitle)
                .padding()
            
            Text("Your Position: \(playerPosition)")
            Text("Computer Position: \(computerPosition)")
                .padding(.bottom)
            
            Text(message)
                .font(.headline)
                .padding()
            
            // Dice representation
            DiceView(value: diceValue)
                .padding()
            
            Button("Roll Dice") {
                rollDice()
            }
            .padding()
            .disabled(currentPlayer == .computer) // Disable the button when it's the computer's turn
            
            Spacer()
            
            // Game Board
            GameBoardView(playerPosition: playerPosition, computerPosition: computerPosition)
                .padding()
        }
        .padding()
    }
    
    func rollDice() {
        diceValue = Int.random(in: 1...6)
        if currentPlayer == .human {
            playerPosition += diceValue
            playerPosition = checkForSnakesOrLadders(at: playerPosition)
            message = "You rolled a \(diceValue)."
            if playerPosition >= winningPosition {
                message = "You win!"
            } else {
                currentPlayer = .computer
                message += " Computer's turn."
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    computerTurn()
                }
            }
        }
    }
    
    func computerTurn() {
        let diceValue = Int.random(in: 1...6)
        computerPosition += diceValue
        computerPosition = checkForSnakesOrLadders(at: computerPosition)
        message = "Computer rolled a \(diceValue)."
        
        if computerPosition >= winningPosition {
            message = "Computer wins!"
        } else {
            currentPlayer = .human
            message += " Your turn!"
        }
    }
    
    func checkForSnakesOrLadders(at position: Int) -> Int {
        if let newPosition = ladders[position] {
            return newPosition // Climb the ladder
        } else if let newPosition = snakes[position] {
            return newPosition // Slide down the snake
        }
        return position // No change
    }
}

// Dice view to display the current dice value
struct DiceView: View {
    let value: Int
    
    var body: some View {
        VStack {
            Text("Dice")
                .font(.title)
            Text("\(value)")
                .font(.largeTitle)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
        }
    }
}

// Game board view to show player positions and the board
struct GameBoardView: View {
    let playerPosition: Int
    let computerPosition: Int

    var body: some View {
        VStack {
            ForEach(0..<10, id: \.self) { row in
                HStack {
                    ForEach((0..<3).reversed(), id: \.self) { column in
                        let position = (row * 3) + column
                        if position == playerPosition {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 30, height: 30)
                        } else if position == computerPosition {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 30, height: 30)
                        } else {
                            Rectangle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.clear)
                        }
                    }
                }
            }
        }
        .frame(width: 300, height: 300)
        .border(Color.black)
    }
}

// Preview for SnakeAndLadderView
struct SnakeAndLadderView_Previews: PreviewProvider {
    static var previews: some View {
        SnakeAndLadderView()
    }
}
