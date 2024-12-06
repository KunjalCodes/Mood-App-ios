import SwiftUI

// Book model with properties for title, author, content, and cover image
struct Book {
    let title: String
    let author: String
    let content: String
    let coverImageName: String
}

struct BookListView: View {
    // Sample books data
    var books: [Book] = [
        Book(title: "The Alchemist", author: "Paulo Coelho", content: "The Alchemist by Paulo Coelho is a philosophical novel that tells the story of Santiago, a young shepherd from Andalusia who dreams of discovering treasure near the Egyptian pyramids. Inspired by a recurring dream, he meets Melchizedek, a mysterious king who encourages him to pursue his Personal Legend, which represents his life's purpose and aspirations. Santiago sells his sheep and embarks on a journey across the desert, where he encounters various characters that teach him valuable life lessons. He meets a crystal merchant who shares the importance of pursuing one's dreams and taking risks, and an Englishman who is in search of the secrets of alchemy. Through their interactions, Santiago learns about the significance of omens, the language of the world, and the transformative power of love and personal growth. As Santiago travels, he falls in love with Fatima, a woman he meets at an oasis, who embodies the idea that true love supports one's personal journey rather than hinders it. Ultimately, Santiago discovers that the real treasure lies not in material wealth but in the wisdom gained through his experiences and the pursuit of his dreams. The novel emphasizes themes of destiny, self-discovery, and the interconnectedness of all things. It encourages readers to listen to their hearts, recognize the signs along their paths, and embrace the journey of life. The Alchemist has become a global bestseller, resonating with audiences for its inspirational message about following one's dreams and the importance of personal transformation.", coverImageName: "alchemist"),
        
        Book(title: "The Immortals of Meluha", author: "Amish Tripathi", content: "The Immortals of Meluha by Amish Tripathi is the first book in the Shiva Trilogy, which reimagines the life of Lord Shiva as a mortal man. Set in ancient India, the story takes place in the idyllic land of Meluha, a technologically advanced empire founded by the Suryavanshis. The narrative follows Shiva, a fierce and powerful warrior from the mountain tribe of the Guna, who embarks on a journey to Meluha to find a better life for his people. Upon his arrival, he learns that Meluha is facing a grave threat from the evil Chandravanshis and their alliance with the infamous villain, the Neelkanth a mythical figure prophesied to save the world. The Suryavanshis believe that Shiva may be the long-awaited Neelkanth, destined to defeat evil and restore order. As Shiva grapples with his newfound identity, he discovers the complexities of fate, duty, and morality. He is welcomed into Meluha, where he meets the beautiful Sati, the daughter of the Meluhan emperor, and he is drawn into a world of political intrigue and divine prophecies. As he navigates his destiny, Shiva faces challenges that test his strength, courage, and understanding of good and evil. The novel blends mythology, philosophy, and adventure, exploring themes of love, sacrifice, and the nature of divinity. Ultimately, The Immortals of Meluha presents a compelling tale of transformation, as Shiva evolves from a mere mortal into a legendary figure, setting the stage for the subsequent books in the trilogy. Through this retelling of ancient myths, Amish Tripathi invites readers to reflect on the complexities of life and the eternal struggle between light and darkness.", coverImageName: "t1"),
        
        Book(title: "The Secret of The Nagas", author: "Amish Tripathi", content: "The Secret of the Nagas is the second book in the Shiva Trilogy by Amish Tripathi, continuing the story of Shiva, the Neelkanth, as he confronts new challenges and deepens his understanding of good and evil. The narrative picks up shortly after the events of The Immortals of Meluha, where Shiva has begun to embrace his identity as a savior. Following the tragic assassination of his beloved Sati, Shiva embarks on a quest to uncover the truth behind her death, leading him to the mysterious land of the Nagas, a tribe shunned by society for their physical deformities and dark reputation. As Shiva investigates, he learns that the Nagas are not the evil beings that the Meluhans believe them to be; instead, they have a rich culture and complex societal structure. Throughout his journey, he encounters various characters, including the enigmatic Naga leader, who reveals deeper layers of their history and the reasons behind their marginalization. The book delves into themes of identity, love, betrayal, and the moral ambiguities that come with the quest for justice. As Shiva uncovers shocking secrets about the past, he must confront his own beliefs and prejudices, ultimately leading him to question the definitions of right and wrong. The narrative combines elements of adventure, mythology, and philosophy, offering readers insights into the intricacies of human nature and the dualities of existence. The Secret of the Nagas serves as a pivotal chapter in Shiva's journey, pushing him to evolve as a leader and a man, setting the stage for the trilogy's concluding volume. Through this captivating tale, Tripathi explores the complexity of relationships and the importance of understanding and compassion in a world filled with conflict and misunderstanding.", coverImageName: "t2"),
        
        Book(title: "The Oath of The Vayuputras", author: "Amish Tripathi", content: "The Oath of the Vayuputras is the concluding volume of the Shiva Trilogy by Amish Tripathi, bringing the epic journey of Lord Shiva to a dramatic and thought-provoking climax. The story picks up where The Secret of the Nagas left off, as Shiva continues his quest to uncover the truth behind the larger conspiracy threatening the world. With the knowledge he has gained, Shiva realizes that the fate of humanity rests upon his shoulders, and he must unite the disparate tribes of India to face a common enemy: the evil forces represented by the Chandravanshis, led by the ruthless emperor Daksha. The narrative explores themes of sacrifice, duty, and the complexities of leadership as Shiva grapples with his role as the Neelkanth and the responsibilities that come with it. As he embarks on a journey to gather allies, Shiva is confronted with deep philosophical questions about free will, morality, and the nature of good and evil. Throughout his adventures, he encounters powerful figures, including the Vayuputras, a secretive order of ascetics and warriors who have been preparing for the final confrontation. The story culminates in an epic battle between the forces of good and evil, where Shiva must make difficult choices that test his resolve and redefine his understanding of love and loyalty. Through rich world-building and intricate character development, The Oath of the Vayuputras combines elements of mythology, spirituality, and human emotion, offering a powerful conclusion to Shiva's transformation from a mere mortal into a legendary figure. As the trilogy comes to an end, Tripathi leaves readers with profound insights into the human condition, the importance of unity in the face of adversity, and the eternal struggle between light and darkness.", coverImageName: "t3")
    ]

    var body: some View {
        List(books, id: \.title) { book in
            NavigationLink(destination: BookDetailView(book: book)) {
                HStack {
                    Image(book.coverImageName) // Display the cover image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 75) // Adjust size as needed
                        .cornerRadius(5)
                    
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Books")
    }
}

// BookDetailView to display book details
struct BookDetailView: View {
    let book: Book

    var body: some View {
        ZStack {
            // Background image for BookDetailView
            Image("flower") // Using the same flower background
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text(book.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("by \(book.author)")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()

                // Cover image
                Image(book.coverImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 180)
                    .cornerRadius(5)
                    .padding()

                // Book content
                ScrollView {
                    Text(book.content)
                        .font(.body)
                        .padding()
                }
            }
        }
    }
}

// Preview for BookListView
struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
