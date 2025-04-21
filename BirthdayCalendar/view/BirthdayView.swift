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
    @State private var birthdayView : BirthdayListViewType = .simpleList
    
    @Query(
        sort: \Birthday.dayOfYearInt,
        order: .forward
    )
    private var birthdayByBirthdays: [Birthday]
    
    
    private var birthdays: [Birthday] {
        return birthdayByBirthdays
    }

    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Picker("Birthday view", selection: $birthdayView) {
                    Text("List").tag(BirthdayListViewType.simpleList)
                    Text("List by month").tag(BirthdayListViewType.groupByMonthList)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                if(birthdayView == BirthdayListViewType.simpleList) {
                    PlainList(isEditMode: $isEditMode, showSheet: $showSheet,  currentBirthday: $currentBirthday, birthdays: birthdays)
                    
                }
                if (birthdayView == BirthdayListViewType.groupByMonthList ) {
                    GroupedByMonthList(isEditMode: $isEditMode, showSheet: $showSheet, currentBirthday: $currentBirthday, birthdays: birthdays)
                }
                
                
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

enum BirthdayListViewType {
    case simpleList
    case groupByMonthList
}




#Preview {
    BirthdayView()
        .modelContainer(for: Birthday.self)
}
