//
//  ContactPicker.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 21/04/2025.
//

import ContactsUI
import SwiftUI

struct ContactPicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPicker

        init(_ parent: ContactPicker) {
            self.parent = parent
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.onSelect(contact)
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            // Optional: Handle cancel if needed
        }
    }

    var onSelect: (CNContact) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
        // No updates needed
    }
}
