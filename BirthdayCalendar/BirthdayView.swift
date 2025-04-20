//
//  BirthdayView.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import SwiftUI

struct BirthdayView: View {
    @State var showSheet: Bool = false

    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Spacer()
            }.navigationTitle("Birthdays")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label : {
                        Label("Advance", systemImage: "text.book.closed")
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showSheet.toggle()
                    }
                    label : {
                        Label("Settings", systemImage: "plus")
                    }
                    Button {}
                    label : {
                        Label("Info", systemImage: "info.circle")
                    }
                }
                    
                }
            .sheet(isPresented: $showSheet) {
                BirthdayFormView()
            }


        }

        
    
        
        
        
    }
}

#Preview {
    BirthdayView()
}
