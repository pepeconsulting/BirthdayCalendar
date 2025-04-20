//
//  BirthdayFormView.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import SwiftUI

struct BirthdayFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var birthday: Birthday
    let onSave: (Birthday) -> Void
        
    
    let dateRange : ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: calendar.component(.year, from: Date()) - 110)
        
        
        return calendar.date(from:startComponents)!
                ...
            Date()
    }()
    
    
    //Disable save button
    var isSaveDisabled : Bool {
        false
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Birthday") {
                    LabeledContent {
                        TextField("", text: $birthday.name)
                    } label: {
                      Label("Name:", systemImage: "person.circle")
                    }
                    
                    DatePicker(selection: $birthday.birthday, in: dateRange, displayedComponents: [.date], label: {
                        Label("Birth date:", systemImage: "calendar")
                    })
                }

            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }.foregroundStyle(.red)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(birthday)
                    
                        dismiss()
                    }
                    .disabled(isSaveDisabled)
                }
            }
        }
    }
}

#Preview {
    BirthdayFormView(birthday: .constant(Birthday()), onSave: {_ in})
}
