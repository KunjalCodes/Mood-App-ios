import SwiftUI
struct MiniGamesView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: TicTacToeGameView()) {
                    Text("Play Tic-Tac-Toe")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: SnakeAndLadderView()) {
                    Text("Play Snake Game")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Mini Games")
        }
    }
}
