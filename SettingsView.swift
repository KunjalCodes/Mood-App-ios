import SwiftUI

struct SettingsView: View {
    @Binding var isDarkMode: Bool
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var musicManager = MusicManager.shared // Access the global MusicManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(isDarkMode ? "dark" : "asback")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // Custom Back Button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Back")
                                .font(.system(size: 18, weight: .bold))
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    // Theme Selection
                    Text("Select Theme")
                        .font(.title)
                        .padding()

                    Picker("Theme", selection: $isDarkMode) {
                        Text("Light Mode").tag(false)
                        Text("Dark Mode").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)

                    // Relaxation Music Link
                    NavigationLink(destination: RelaxationMusicView(isDarkMode: $isDarkMode)) {
                        Text("Relaxation Music")
                            .font(.system(size: 20))
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .background(Color(red: 1.0, green: 0.8, blue: 0.8))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                    .padding()

                    // Stop Music Button
                    Button(action: {
                        musicManager.stopMusic()
                    }) {
                        Text("Stop Music")
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.red.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("OK")
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(red: 1.0, green: 0.8, blue: 0.8))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                }
                .navigationTitle("Settings")
                .padding()
            }
        }
    }
}
