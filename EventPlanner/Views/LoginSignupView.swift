//
//  LoginView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

struct LoginSignupView: View {
    
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                if !UserDefaults.standard.bool(forKey: Constants.Labels.guestLoginKey) {
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
                    .padding()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(!viewModel.isLoginView ? Constants.Labels.createAccount : Constants.Labels.Questions.emailPassword)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 40)
                        TextFieldView(placeholder: Constants.Labels.Placeholders.email, text: $viewModel.email)
                        if viewModel.showEmailWarning() {
                            Text(Constants.Labels.Warnings.email)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                        TextFieldView(placeholder: Constants.Labels.Placeholders.password, text: $viewModel.password)
                            .padding(.top)
                        if viewModel.showPasswordWarning() {
                            Text(Constants.Labels.Warnings.password)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                        Text(Constants.Labels.passwordRule)
                            .fontWeight(.semibold)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if viewModel.isLoginView {
                            HStack {
                                Button(Constants.Labels.forgotPassword) {
                                    viewModel.showForgotPasswordSheet.toggle()
                                }
                                .foregroundColor(Constants.Colors.blueThemeColor)
                                .fullScreenCover(isPresented: $viewModel.showForgotPasswordSheet) {
                                    ForgotPasswordView()
                                }
                            }
                            .padding(.top)
                        }
                        
                        Button {
                            viewModel.buttonClicked()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 60)
                                    .foregroundColor(viewModel.loginButtonDisabled() ? .gray : Constants.Colors.blueThemeColor)
                                    .cornerRadius(10)
                                Text(viewModel.isLoginView ? Constants.Labels.logIn : Constants.Labels.signUp)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                        .disabled(viewModel.loginButtonDisabled())
                        .fullScreenCover(isPresented: $viewModel.presentMainTabView) {
                            MainTabView()
                        }
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(
                                title: Text(""), message: Text(viewModel.alertMessage),
                                dismissButton: .default(Text(Constants.Labels.ok)
                                    .foregroundColor(Constants.Colors.blueThemeColor)))
                        }

                        
                        if !UserDefaults.standard.bool(forKey: Constants.Labels.guestLoginKey) {
                            Button {
                                viewModel.loginGuest()
                            } label: {
                                Text(Constants.Labels.guestLogin)
                                    .fontWeight(.semibold)
                                    .padding()
                                    .frame(width: 350, height: 60)
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                            }
                            .fullScreenCover(isPresented: $viewModel.presentMainTabView) {
                                MainTabView()
                        }
                        }
                        
                        HStack {
                            Text(viewModel.isLoginView ? Constants.Labels.notMember : Constants.Labels.alreadyMember)
                            Button(!viewModel.isLoginView ? Constants.Labels.logIn : Constants.Labels.signUp) {
                                withAnimation {
                                    viewModel.isLoginView.toggle()
                                }
                            }
                            .foregroundColor(Constants.Colors.blueThemeColor)
                        }
                        .padding(.top)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 40)
                Spacer()
            }
            
            if viewModel.isLoggedIn {
                LoadingView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupView()
    }
}
