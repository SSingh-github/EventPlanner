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
        NavigationStack {
            ZStack {
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
                        viewModel.forgotPassword()
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
                    }.navigationDestination(isPresented: $viewModel.presentOtpView, destination: {
                        OtpView(viewModel: viewModel)
                    })
                    .disabled(viewModel.buttonDisabled())
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text(""), message: Text(viewModel.alertMessage),
                            dismissButton: .default(Text(Constants.Labels.ok)
                                .foregroundColor(Constants.Colors.blueThemeColor)))
                    }
                    Spacer()
                }
                .padding()
                
                if viewModel.forgotPasswordLoading {
                    LoadingView()
                }
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ForgotPasswordView()
        }
    }
}
