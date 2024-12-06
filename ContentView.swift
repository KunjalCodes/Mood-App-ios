import SwiftUI

struct ContentView: View {
    let moods = [
        ("😀", "Happy"),
        ("😢", "Sad"),
        ("😡", "Angry"),
        ("😌", "Relaxed"),
        ("😨", "Anxious"),
        ("😐", "Neutral")
    ]

    @State private var selectedMood: String? = nil
    @State private var showNoteField: Bool = false
    @State private var note: String = ""
    @State private var calendarData: [String: (String, String?)] = [:]
    @State private var navigateToCalendar = false
    @State private var navigateToSettings = false
    @State private var navigateToAnalytics = false
    @State private var navigateToGames = false
    @State private var navigateToMoodLift = false // State for mood lift options
    @State private var isDarkMode = false

    let today: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }()

    var body: some View {
        NavigationView {
            ZStack {
                Image(isDarkMode ? "dark" : "asback")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("How was your mood today?")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(isDarkMode ? .white : .black)
                        .padding(.top, 40)
                        .multilineTextAlignment(.center)
                    
                    // Mood Selection
                    if selectedMood == nil {
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(moods, id: \.0) { mood in
                                Button(action: {
                                    selectedMood = mood.0
                                }) {
                                    Text(mood.0)
                                        .font(.system(size: 60))
                                        .frame(width: 80, height: 80)
                                        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .contextMenu {
                                    Text(mood.1)
                                }
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 15) {
                            Text("You selected: \(selectedMood!)")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(isDarkMode ? .white : .black)
                            
                            Button(action: {
                                showNoteField.toggle()
                            }) {
                                Text(showNoteField ? "Hide Note Field" : "Add a Note")
                                    .font(.system(size: 18))
                                    .frame(width: UIScreen.main.bounds.width * 0.8)
                                    .padding()
                                    .background(Color(red: 1.0, green: 0.8, blue: 0.8))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                            
                            if showNoteField {
                                TextField("Write something about today", text: $note)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .font(.system(size: 16))
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(8)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                            
                            Button(action: {
                                saveMood()
                                navigateToCalendar = true
                            }) {
                                Text("Save and View Calendar")
                                    .font(.system(size: 18))
                                    .frame(width: UIScreen.main.bounds.width * 0.8)
                                    .padding()
                                    .background(Color(red: 1.0, green: 0.8, blue: 0.8))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                            
                            Button(action: {
                                navigateToAnalytics = true
                            }) {
                                Text("View Analytics")
                                    .font(.system(size: 18))
                                    .frame(width: UIScreen.main.bounds.width * 0.8)
                                    .padding()
                                    .background(Color(red: 0.96, green: 0.87, blue: 0.7))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                        }
                        .padding(.top, 20)
                    }
                    
                    // Mini-Games Button
                    Button(action: {
                        navigateToGames = true
                    }) {
                        Text("Play Mini-Games")
                            .font(.system(size: 18))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .padding()
                            .background(Color(red: 0.5, green: 0.7, blue: 1.0))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                    
                    // Lift Up Your Mood Button
                    Button(action: {
                        navigateToMoodLift = true
                    }) {
                        Text("Lift Up Your Mood")
                            .font(.system(size: 18))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .padding()
                            .background(Color(red: 1.0, green: 0.8, blue: 0.9)) // Light pink color
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                }

                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .navigationTitle("Mood")
                .navigationBarTitleDisplayMode(.inline)

                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            navigateToSettings = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                    }
                }

                .background(
                    NavigationLink(destination: CalendarView(calendarData: $calendarData, isDarkMode: $isDarkMode), isActive: $navigateToCalendar) {
                        EmptyView()
                    }
                    .hidden()
                )

                .background(
                    NavigationLink(destination:  SettingsView(isDarkMode: $isDarkMode), isActive: $navigateToSettings) {
                        EmptyView()
                    }
                    .hidden()
                )

                .background(
                    NavigationLink(destination: AnalyticsView(calendarData: $calendarData, isDarkMode: $isDarkMode), isActive: $navigateToAnalytics) {
                        EmptyView()
                    }
                    .hidden()
                )

                .background(
                    NavigationLink(destination: MiniGamesView(), isActive: $navigateToGames) {
                        EmptyView()
                    }
                    .hidden()
                )

                .background(
                    NavigationLink(destination: MoodLiftView(), isActive: $navigateToMoodLift) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
            .onAppear {
                loadCalendarData()
            }
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
        }
    }

    // Save mood and note
    func saveMood() {
        calendarData[today] = (selectedMood ?? "", note.isEmpty ? nil : note)
        saveCalendarData()
        resetForNextDay()
    }

    func resetForNextDay() {
        selectedMood = nil
        note = ""
        showNoteField = false
    }

    func saveCalendarData() {
        let calendarDataForStorage = calendarData.mapValues { (mood, note) in
            ["mood": mood, "note": note ?? ""]
        }
        UserDefaults.standard.set(calendarDataForStorage, forKey: "calendarData")
    }

    func loadCalendarData() {
        if let savedData = UserDefaults.standard.dictionary(forKey: "calendarData") as? [String: [String: String]] {
            calendarData = savedData.mapValues { dict in
                (dict["mood"] ?? "", dict["note"]?.isEmpty == false ? dict["note"] : nil)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
