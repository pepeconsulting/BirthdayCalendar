//
//  BirthdayCardTests.swift
//  BirthdayCalendarTests
//
//  Created by Ola Loevholm on 20/04/2025.
//

import XCTest
import SwiftUI
@testable import BirthdayCalendar
import ViewInspector

final class BirthdayCardTests: XCTestCase {

    func testBirthdayCardDisplaysCorrectInformation() throws {
        // Arrange
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let birthDate = dateFormatter.date(from: "1990/04/20")!
        let birthday = Birthday(name: "Ola", birthday: birthDate)
        let card = BirthdayCard(birthday: birthday)

        // Act
        let hStack = try card.inspect().hStack()

        // Assert
        XCTAssertEqual(try hStack.text(0).string(), "Ola")
        XCTAssertEqual(try hStack.text(1).string(), birthday.formattedDate)
        XCTAssertEqual(try hStack.text(2).string(), "turns \(birthday.ageThisYear) this year")
    }
}
