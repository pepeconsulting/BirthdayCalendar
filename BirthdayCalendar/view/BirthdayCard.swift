//
//  BirthdayCard.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import SwiftUI

struct BirthdayCard: View {
    var birthday: Birthday
    var body: some View {
        HStack {
            Text(birthday.name)
                .fontWeight(.bold)
            Text(birthday.formattedDate)
                .fontWeight(.regular)
            Text("\(String(birthday.ageThisYear)) this year")
        }
    }
}

#Preview {
    let birthday = Birthday(name: "Test", birthday: Date())
    BirthdayCard(birthday: birthday)
}
