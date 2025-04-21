//
//  BirthdayFormView.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import SwiftUI

struct BirthdayFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isEditing: Bool
    @Binding var birthday: Birthday
    let onSave: (Birthday) -> Void
    
    @State private var selectionFilter: CreateByFilter = .fromContacts
    @State private var showContactPicker = false

    
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
                if(!isEditing) {
                    Picker("Get contact", selection: $selectionFilter) {
                        Text("Fetch from contacts").tag(CreateByFilter.fromContacts)
                        Text("Add/edit manually").tag(CreateByFilter.addManually)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                if(!isEditing && selectionFilter == CreateByFilter.fromContacts) {
                    Section("Import from contacts") {
                        Button {
                            showContactPicker.toggle()
                        } label: {
                            Label("Get from your contacts", systemImage: "person.crop.circle.fill")
                        }
                    }
                }
                
                if(isEditing || selectionFilter == CreateByFilter.addManually) {
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
            .sheet(isPresented: $showContactPicker) {
                ContactPicker { contact in
                    birthday.name = "\(contact.givenName) \(contact.familyName)"
                    if(contact.birthday != nil) {
                        birthday.birthday = dateFromDateComponents(contact.birthday ?? DateComponents()) ?? Date()
                    }
                    selectionFilter = .addManually
                }
            }
        }
    }
    
    func dateFromDateComponents(_ dateComponents: DateComponents) -> Date? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        return calendar.date(from: dateComponents)
    }
}

enum CreateByFilter {
    case none
    case fromContacts
    case addManually
}




#Preview {
    BirthdayFormView(isEditing: .constant(false), birthday: .constant(Birthday()), onSave: {_ in})
}
