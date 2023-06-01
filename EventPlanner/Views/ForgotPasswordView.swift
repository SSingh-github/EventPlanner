//
//  ForgotPasswordView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: Constants.Images.xmark)
                            .font(.title)
                            .foregroundColor(Constants.Colors.blueThemeColor)
                        Spacer()
                    }
                }
                .padding(.vertical)
                
                Text(Constants.Labels.forgotPassword)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 40)
                
                Text(Constants.Labels.enterEmail)
                TextFieldView(placeholder: Constants.Labels.Placeholders.email, text: $viewModel.email)
                
                if viewModel.showEmailWarning() {
                    Text(Constants.Labels.Warnings.email)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .padding(.bottom)
                }
                
                Text(Constants.Labels.otpMessage)
                    .fontWeight(.semibold)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                
                Button {
                    viewModel.presentOtpView.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(viewModel.buttonDisabled() ? .gray : Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text(Constants.Labels.sendOtp)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(viewModel.buttonDisabled())
                NavigationLink(destination: OtpView(viewModel: viewModel), isActive: $viewModel.presentOtpView) {
                                EmptyView()
                            }
                            .hidden()
                Spacer()
            }
            .padding()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
