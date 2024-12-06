import SwiftUI

struct MoodLiftView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = false
    @State private var navigateToJournal = false
    @State private var navigateToBooks = false

    var body: some View {
        ZStack {
            // Background image based on dark mode
            Image("flower") // Changed to use the flower background
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Lift Up Your Mood")
                    .font(.largeTitle)
                    .padding()

                // Navigate to Journal View
                NavigationLink(destination: JournalView(), isActive: $navigateToJournal) {
                    Button(action: {
                        navigateToJournal = true
                    }) {
                        Text("Write Your Daily Journal")
                            .font(.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.6)
                            .padding()
                            .background(Color(red: 1.0, green: 0.8, blue: 0.8)) // Light pink background
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                }

                // Navigate to Book List View
                NavigationLink(destination: BookListView(), isActive: $navigateToBooks) {
                    Button(action: {
                        navigateToBooks = true
                    }) {
                        Text("Read a Book")
                            .font(.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.6)
                            .padding()
                            .background(Color(red: 1.0, green: 0.8, blue: 0.8)) // Light pink background
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                }
            }
        }
        .onAppear {
            isDarkMode = colorScheme == .dark
        }
    }
}

struct MoodLiftView_Previews: PreviewProvider {
    static var previews: some View {
        MoodLiftView()
    }
}
