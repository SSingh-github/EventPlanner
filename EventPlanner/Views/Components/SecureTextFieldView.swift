//
//  SecureTextFieldView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

import SwiftUI

struct SecureTextFieldView: View {
    var placeholder: String
    @Binding var text: String
    @State private var isPasswordVisible = false // Track the visibility state of the password
    
    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField(placeholder, text: $text)
                    .disableAutocorrection(true)
            } else {
                SecureField(placeholder, text: $text)
                    .disableAutocorrection(true)
            }
            
            Button(action: {
                isPasswordVisible.toggle() // Toggle the visibility state
            }) {
                Image(systemName: isPasswordVisible ? Constants.Images.eyeSlash : Constants.Images.eye)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(height: 60)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .accentColor(Constants.Colors.blueThemeColor)
    }
}


