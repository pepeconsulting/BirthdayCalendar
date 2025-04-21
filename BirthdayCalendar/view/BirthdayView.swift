//
//  BirthdayView.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import SwiftUI
import SwiftData

struct BirthdayView: View {
    @Environment(\.modelContext) private var modelContext

    
    @State var showSheet: Bool = false
    @State private var currentBirthday: Birthday = Birthday()
    @State private var isEditMode: Bool = false
    
    @Query(
        sort: \Birthday.birthday,
        order: .forward
    )
    private var birthdayByBirthdays: [Birthday]
    
    
    private var birthdays: [Birthday] {
        return birthdayByBirthdays
    }


    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                List {
                    ForEach(birthdays) { birthday in
                        BirthdayCard(birthday: birthday)
                            .onTapGesture {
                                isEditMode = true
                                currentBirthday = birthday
                                showSheet.toggle()
                            }

                    }                }
                
                
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
                        isEditMode = false
                        currentBirthday = Birthday()
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
                BirthdayFormView(isEditing: $isEditMode, birthday: $currentBirthday) { newBirthday in
                    modelContext.insert(currentBirthday)
                    try? modelContext.save()
                    
                    showSheet.toggle()
                    
                }
            }


        }

        
    
        
        
        
    }
}

#Preview {
    BirthdayView()
        .modelContainer(for: Birthday.self)
}
