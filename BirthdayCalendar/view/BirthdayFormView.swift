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
    
    @State private var selectionFilter: Filter = .fromContacts
        
    
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
                Picker("Get contact", selection: $selectionFilter) {
                    Text("From contacts").tag(Filter.fromContacts)
                    Text("Add manually").tag(Filter.addManually)
                }.pickerStyle(SegmentedPickerStyle())
                
                if(selectionFilter == Filter.fromContacts) {
                    Section("Import from contacts") {
                        Button {
                        } label: {
                            Label("Connect to contacts", systemImage: "person.crop.circle.fill")
                        }.disabled(true)
                    }
                }
                
                if(selectionFilter == Filter.addManually) {
                    Section("Add manually") {
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
                
                // Share and import from contacts:
                Section("Things") {
                    Button {
                    } label: {
                        Label("Share contact", systemImage: "square.and.arrow.up")
                    }.disabled(true)
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

enum Filter {
    case none
    case fromContacts
    case addManually
}

#Preview {
    BirthdayFormView(birthday: .constant(Birthday()), onSave: {_ in})
}
