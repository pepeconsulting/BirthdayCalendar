//
//  Birthday.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import Foundation
import SwiftData

@Model
class Birthday: Identifiable {
    var name: String
    var birthday: Date
    
    var ageThisYear : Int {
        let calendar = Calendar.current
        let birthYear = calendar.component(.year, from: birthday)
        let currentYear = calendar.component(.year, from: Date())
        return currentYear - birthYear
    }
    
    var formattedDate : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM" // e.g., "April 20"
        return formatter.string(from: birthday)
    }
    
    var isPassedThisYear: Bool {
        let calendar = Calendar.current
        let now = Date()

        var birthdayThisYear = calendar.date(
            bySettingHour: 0, minute: 0, second: 0, of: birthday
        ) ?? birthday

        // Replace the year of the birthday with the current year
        let currentYear = calendar.component(.year, from: now)
        let components = calendar.dateComponents([.month, .day], from: birthday)
        birthdayThisYear = calendar.date(from: DateComponents(
            year: currentYear,
            month: components.month,
            day: components.day
        )) ?? birthday

        return birthdayThisYear < now
    }
    
    
    init(name: String = "", birthday: Date = Date()) {
        self.name = name
        self.birthday = birthday
    }
    
}
