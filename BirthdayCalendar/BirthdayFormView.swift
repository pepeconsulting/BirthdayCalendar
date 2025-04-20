//
//  BirthdayFormView.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import SwiftUI

struct BirthdayFormView: View {
    @Environment(\.dismiss) private var dismiss
    
    
    
    
    //Disable save button
    var isSaveDisabled : Bool {
        return true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }.foregroundStyle(.red)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                    .disabled(isSaveDisabled)
                }
            }
        }
    }
}

#Preview {
    BirthdayFormView()
}
