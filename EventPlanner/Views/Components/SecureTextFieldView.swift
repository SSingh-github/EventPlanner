//
//  SecureTextFieldView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

struct SecureTextFieldView: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .frame(height: 60)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .accentColor(Constants.Colors.blueThemeColor)
    }
}

