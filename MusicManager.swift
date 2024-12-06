import AVFoundation
import SwiftUI

class MusicManager: ObservableObject {
    static let shared = MusicManager()
    private var audioPlayer: AVAudioPlayer?
    
    // Function to play music
    func playMusic(named: String) {
        let musicFile = named.replacingOccurrences(of: " ", with: "") // Removing spaces for consistency
        if let url = Bundle.main.url(forResource: musicFile, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // Infinite loop
                audioPlayer?.play()
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        } else {
            print("Music file \(musicFile) not found")
        }
    }
    
    // Function to stop music
    func stopMusic() {
        audioPlayer?.stop()
    }
    
    // Function to check if the music is playing
    func isPlaying() -> Bool {
        return audioPlayer?.isPlaying ?? false
    }
}
