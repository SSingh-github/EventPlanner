//
//  TextFieldView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

struct TextFieldView: View {
    var placeholder: String
    @Binding var text: String
    var axis: Axis = .horizontal
    
    var body: some View {
        TextField(placeholder, text: $text, axis: axis)
            .disableAutocorrection(true)
            .padding()
            .frame(height: 60)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .accentColor(Constants.Colors.blueThemeColor)
    }
}

