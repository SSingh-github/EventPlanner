//
//  ResetPasswordView.swift
//  EventPlanner
//
//  Created by Chicmic on 01/06/23.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @ObservedObject var viewModel: ForgotPasswordViewModel
    //@Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.Labels.enterNewPassword)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 40)
            
            Text(Constants.Labels.enterPassword)
            SecureTextFieldView(placeholder: Constants.Labels.Placeholders.password, text: $viewModel.newPassword)
            
            if viewModel.showPasswordWarning() {
                Text(Constants.Labels.Warnings.password)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
            Text(Constants.Labels.passwordRule)
                .fontWeight(.semibold)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom)
            
            
            Text(Constants.Labels.confirmPassword)
            SecureTextFieldView(placeholder: Constants.Labels.Placeholders.password, text: $viewModel.confirmPassword)
            
            if viewModel.showConfirmPasswordWarning() {
                Text(Constants.Labels.Warnings.confirmPassword)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
            Button {
                viewModel.resetPassword()
//                if viewModel.resetPasswordSuccessful{
//                    presentationMode.wrappedValue.dismiss()
//                }
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 60)
                        .foregroundColor(viewModel.resetPasswordButtonDisabled() ? .gray : Constants.Colors.blueThemeColor)
                        .cornerRadius(10)
                    Text(Constants.Labels.changePassword)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
            
            .fullScreenCover(isPresented: $viewModel.showLoginView, content: {
                LoginSignupView()
            })
            .disabled(viewModel.resetPasswordButtonDisabled())
            .padding(.top, 50)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(""), message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text(Constants.Labels.ok)
                        .foregroundColor(Constants.Colors.blueThemeColor)))
            }

            Spacer()
        }
        .padding()
        .padding(.top, 30)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(viewModel: ForgotPasswordViewModel())
    }
}
