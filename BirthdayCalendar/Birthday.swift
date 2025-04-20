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
    
    init(name: String = "", birthday: Date = Date()) {
        self.name = name
        self.birthday = birthday
    }
    
}
