import SwiftUI
import Charts

struct AnalyticsView: View {
    @Binding var calendarData: [String: (String, String?)] // Binding to the calendar data from ContentView
    @Binding var isDarkMode: Bool // Binding to dark mode state

    // A dictionary to store the count of each mood
    var moodCounts: [String: Int] {
        var counts: [String: Int] = [:]
        for (_, (mood, _)) in calendarData {
            counts[mood, default: 0] += 1
        }
        return counts
    }

    // Define colors for each mood
    let moodColors: [String: Color] = [
        "😀": .yellow,
        "😢": .blue,
        "😡": .red,
        "😌": .green,
        "😨": .orange,
        "😐": .gray
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background image
                Image(isDarkMode ? "dark" : "asback")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all) // Fill the entire screen

                VStack(spacing: 20) {
                    // Title
                    Text("Mood Analytics")
                        .font(.system(size: geometry.size.height * 0.04)) // Dynamic title size based on height
                        .foregroundColor(isDarkMode ? .white : .black)
                        .padding(.top, geometry.size.height * 0.02)
                        .frame(maxWidth: .infinity) // Center the title

                    // Mood Count Statistics
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(moodCounts.sorted(by: { $0.value > $1.value }), id: \.key) { mood, count in
                                HStack {
                                    Text("\(mood) - \(count) entries")
                                        .font(.system(size: geometry.size.height * 0.02))
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    Text("\(String(format: "%.1f", (Double(count) / Double(calendarData.count)) * 100))%")
                                        .font(.system(size: geometry.size.height * 0.02))
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .padding()
                                .background(moodColors[mood]?.opacity(0.3) ?? Color.clear)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity) // Center the mood statistics
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: geometry.size.height * 0.35) // Adjusted height for scrollable mood stats

                    // Pie Chart
                    if moodCounts.isEmpty {
                        Text("No mood data available")
                            .font(.system(size: geometry.size.height * 0.02))
                            .foregroundColor(isDarkMode ? .white : .black)
                            .padding()
                            .frame(maxWidth: .infinity) // Center this message
                    } else {
                        Chart {
                            ForEach(moodCounts.sorted(by: { $0.value > $1.value }), id: \.key) { mood, count in
                                SectorMark(
                                    angle: .value("Count", Double(count)),
                                    innerRadius: .ratio(0.5),
                                    outerRadius: .ratio(0.9)
                                )
                                .foregroundStyle(moodColors[mood] ?? Color.gray)
                            }
                        }
                        .chartBackground { proxy in
                            GeometryReader { geometry in
                                Text("Total Entries: \(calendarData.count)")
                                    .font(.system(size: geometry.size.height * 0.02))
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            }
                        }
                        .frame(height: geometry.size.height * 0.3) // Dynamic height based on screen size
                        .padding()
                        .frame(maxWidth: .infinity) // Center the pie chart
                    }

                    Spacer()

                    // Guidance Text
                    Text("Use the pie chart to understand the distribution of your moods over time.")
                        .font(.system(size: geometry.size.height * 0.018))
                        .foregroundColor(isDarkMode ? .white : .black)
                        .padding(.bottom, geometry.size.height * 0.02)
                        .frame(maxWidth: .infinity) // Center this text
                }
                .navigationTitle("Analytics")
                .padding(.horizontal)
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Ensure the ZStack fits the screen
        }
    }
}
