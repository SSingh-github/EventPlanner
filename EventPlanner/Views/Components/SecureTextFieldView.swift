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
    @State private var isPasswordVisible = false
    
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
                isPasswordVisible.toggle() 
            }) {
                Image(systemName: isPasswordVisible ? Constants.Images.eye : Constants.Images.eyeSlash)
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


