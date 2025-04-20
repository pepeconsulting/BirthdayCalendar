//
//  BirthdayCalendarApp.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 20/04/2025.
//

import SwiftUI

@main
struct BirthdayCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            BirthdayView().modelContainer(for: Birthday.self)
        }
    }
}
