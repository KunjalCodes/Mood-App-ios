import SwiftUI

struct CalendarView: View {
    @Binding var calendarData: [String: (String, String?)] // Binding to the calendar data from ContentView
    @Binding var isDarkMode: Bool // Binding to dark mode state
    @State private var selectedDate: String?
    
    @Environment(\.presentationMode) var presentationMode // For dismissing the view

    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image(isDarkMode ? "dark" : "asback") // Use the appropriate background image for light/dark mode
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all) // Fill the entire screen

                VStack {
                    // Custom Back Button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Dismiss the current view
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

                    Text("Your Mood Calendar")
                        .font(.title)
                        .foregroundColor(isDarkMode ? .white : .black) // Change title color based on dark mode
                        .padding()

                    // Creating a simple calendar layout
                    let daysInMonth = 30 // For simplicity, we'll use a static number
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 7) // 7 columns for days of the week

                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(1...daysInMonth, id: \.self) { day in
                            let dateString = String(format: "%02d/%02d/%04d", day, 10, 2024) // Change to your required month and year
                            Button(action: {
                                selectedDate = dateString
                            }) {
                                VStack {
                                    Text("\(day)")
                                        .font(.headline)
                                        .foregroundColor(isDarkMode ? .white : .black) // Adjust day text color based on dark mode

                                    if let (mood, _) = calendarData[dateString] {
                                        Text(mood) // Display the mood emoji
                                            .font(.largeTitle)
                                            .foregroundColor(isDarkMode ? .white : .black) // Adjust mood color based on dark mode
                                    } else {
                                        Text(" ") // Placeholder for empty days
                                    }
                                }
                                .frame(width: 50, height: 70) // Size for each day cell
                                .background(Color.clear) // No extra background color
                                .cornerRadius(8)
                                .padding(5)
                            }
                        }
                    }

                    Spacer()

                   
                    if let selectedDate = selectedDate {
                        let (mood, note) = calendarData[selectedDate] ?? ("No entry", nil)
                        VStack {
                            Text("Mood for \(selectedDate):")
                                .font(.headline)
                                .foregroundColor(isDarkMode ? .white : .black) // Adjust text color based on dark mode

                            Text(mood)
                                .font(.largeTitle)
                                .foregroundColor(isDarkMode ? .white : .black) // Adjust mood color based on dark mode

                            if let note = note, !note.isEmpty {
                                Text("Note:")
                                    .font(.headline)
                                    .foregroundColor(isDarkMode ? .white : .black) // Adjust note title color
                                Text(note)
                                    .padding()
                                    .background(isDarkMode ? Color.gray.opacity(0.4) : Color.gray.opacity(0.2)) // Change note background for dark mode
                                    .cornerRadius(8)
                                    .foregroundColor(isDarkMode ? .white : .black) // Change note text color
                            } else {
                                Text("No notes for this date.")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(isDarkMode ? Color.black.opacity(0.7) : Color.white) // Change background for selected date based on dark mode
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .navigationTitle("Mood Calendar")
                .padding()
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(calendarData: .constant(["01/01/2024": ("😀", "Happy")]), isDarkMode: .constant(false))
    }
}
