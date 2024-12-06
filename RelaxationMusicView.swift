import SwiftUI

struct RelaxationMusicView: View {
    @Binding var isDarkMode: Bool
    @ObservedObject var musicManager = MusicManager.shared // Use the shared instance
    
    let musicOptions = ["Calm Waves", "Forest Sounds", "Rainy Day"]

    var body: some View {
        ZStack {
            // Apply background based on theme
            Image(isDarkMode ? "dark" : "asback")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Relaxation Music")
                    .font(.largeTitle)
                    .padding()

                // List of music options
                List(musicOptions, id: \.self) { music in
                    Button(action: {
                        musicManager.playMusic(named: music)
                    }) {
                        Text(music)
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .listStyle(PlainListStyle())
                .padding()
                
                // Button to stop the music
                Button(action: {
                    musicManager.stopMusic()
                }) {
                    Text("Stop Music")
                        .font(.title2)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .padding()
            }
        }
    }
}

// Preview for RelaxationMusicView
struct RelaxationMusicView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxationMusicView(isDarkMode: .constant(false))
    }
}
