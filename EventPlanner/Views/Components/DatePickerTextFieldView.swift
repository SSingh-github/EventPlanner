//
//  DatePickerTextFieldView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct DatePickerTextFieldView: View {
    
    let label: String
    let placeholder: String
    @Binding var date: Date?
    let minimumDate: Date?
    let pickerType: PickerType
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            DatePickerTextField(placeholder: placeholder, date: $date ,pickerType: pickerType, minimumDate: minimumDate)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .frame(width: 70, height: 60)
                .padding()
        }
    }
}
