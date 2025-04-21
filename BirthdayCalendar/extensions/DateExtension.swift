//
//  DateExtensions.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 21/04/2025.
//

import Foundation

extension Date {
    /// Returns the month number (1 = January, 12 = December)
    var monthNumber: Int {
        Calendar.current.component(.month, from: self)
    }
    
    /// Returns the localized full month name (e.g., "April", "Abril", "Avril")
    var localizedMonthName: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current // Uses the user's system locale
        formatter.dateFormat = "LLLL" // Full month name
        return formatter.string(from: self)
    }
    
}
