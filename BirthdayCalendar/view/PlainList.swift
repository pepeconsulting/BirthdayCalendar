//
//  PlainList.swift
//  BirthdayCalendar
//
//  Created by Ola Loevholm on 21/04/2025.
//

import SwiftUI

struct PlainList : View {
    
    @Binding var isEditMode : Bool
    @Binding var showSheet : Bool
    @Binding var currentBirthday : Birthday
    var birthdays : [Birthday]
    
    var body : some View {
        List {
            ForEach(birthdays) { birthday in
                BirthdayCard(birthday: birthday)
                    .onTapGesture {
                        isEditMode = true
                        currentBirthday = birthday
                        showSheet.toggle()
                    }
                
            }
        }
    }
}
