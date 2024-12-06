import SwiftUI
import UIKit

struct RichTextEditor: UIViewRepresentable {
    @Binding var text: NSAttributedString // Binding to the rich text content

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextEditor

        init(parent: RichTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.attributedText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
}
