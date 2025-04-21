//
//  GroupedByMonthList.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 21/04/2025.
//

import SwiftUI

struct GroupedByMonthList : View {
    @Binding var isEditMode : Bool
    @Binding var showSheet : Bool
    @Binding var currentBirthday : Birthday
    var birthdays : [Birthday]
    
    var body: some View {
        List {
            ForEach(groupedBirthdays.keys.sorted(), id: \.self) { monthNumber in
                Section(header: Text(monthName(from: monthNumber))) {
                    ForEach(groupedBirthdays[monthNumber] ?? []) { birthday in
                        // Customize your row here
                        Text("\(birthday.name) – \(birthday.formattedDate)")
                    }
                }
            }
        }
    }

    private var groupedBirthdays: [Int: [Birthday]] {
        Dictionary(grouping: birthdays) { $0.birthday.monthNumber }
    }

    private func monthName(from number: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        let dateComponents = DateComponents(calendar: Calendar.current, month: number)
        return formatter.monthSymbols[number - 1] // Or use: formatter.string(from: calendar.date(from: dateComponents)!)
    }
}
