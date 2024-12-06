import SwiftUI

struct JournalView: View {
    @State private var journalEntry: String = "" // State variable for journal text
    @State private var savedEntries: [String] = [] // State variable for saved entries

    var body: some View {
        VStack(spacing: 20) {
            Text("Daily Journal")
                .font(.largeTitle)
                .padding()

            // Text editor for writing journal entry
            TextEditor(text: $journalEntry)
                .padding()
                .frame(height: 300) // Fixed height for the text editor
                .border(Color.gray, width: 1) // Border for the text editor
                .cornerRadius(8)
            
            // Save Button
            Button(action: {
                saveEntry()
            }) {
                Text("Save Entry")
                    .font(.system(size: 20))
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
            }
            
            // Display saved entries
            List(savedEntries, id: \.self) { entry in
                Text(entry)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
            }
        }
        .padding()
        .onAppear {
            loadEntries() // Load saved entries when the view appears
        }
        .navigationTitle("Daily Journal")
    }

    // Save the journal entry
    func saveEntry() {
        if !journalEntry.isEmpty {
            savedEntries.append(journalEntry) // Add the entry to the list
            UserDefaults.standard.set(savedEntries, forKey: "journalEntries") // Save to UserDefaults
            journalEntry = "" // Clear the text editor
        }
    }

    // Load saved entries from UserDefaults
    func loadEntries() {
        if let savedData = UserDefaults.standard.array(forKey: "journalEntries") as? [String] {
            savedEntries = savedData
        }
    }
}
