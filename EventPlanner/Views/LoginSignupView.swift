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
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(!viewModel.isLoginView ? Constants.Labels.createAccount : Constants.Labels.Questions.emailPassword)
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.bottom, 40)
                            
                            //MARK: EMAIL FIELD
                            TextField(Constants.Labels.Placeholders.email, text: $viewModel.email)
                                .disableAutocorrection(true)
                                .padding()
                                .frame(height: 60)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .accentColor(Constants.Colors.blueThemeColor)
                            
                            if viewModel.showEmailWarning() {
                                Text(Constants.Labels.Warnings.email)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.red)
                            }
                            
                            //MARK: PASSWORD FIELD
                            SecureTextFieldView(placeholder: Constants.Labels.Placeholders.password, text: $viewModel.password)
                                .padding(.top)
                            
                            if !viewModel.isLoginView {
                                //MARK: CONFIRM PASSWORD FIELD
                                SecureTextFieldView(placeholder: Constants.Labels.Placeholders.confirmPassword, text: $viewModel.confirmPassword)
                                    .padding(.top)
                            }
                            
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
                                //MARK: FORGOT PASSWORD BUTTON
                                HStack {
                                    Button(Constants.Labels.forgotPassword) {
                                        viewModel.showForgotPasswordSheet.toggle()
                                    }
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                                    .fullScreenCover(isPresented: $viewModel.showForgotPasswordSheet) {
                                        ForgotPasswordView()
                                            .environmentObject(viewModel)
                                    }
                                }
                                .padding(.top)
                            }
                            
                            //MARK: LOGIN/SIGNUP BUTTON
                            Button {
                                if viewModel.isLoginView {
                                    viewModel.buttonClicked()
                                }
                                else {
                                    viewModel.showCreateProfileView.toggle()
                                }
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(height: 60)
                                        .foregroundColor(viewModel.loginButtonDisabled() ? .gray : Constants.Colors.blueThemeColor)
                                        .cornerRadius(10)
                                    Text(viewModel.isLoginView ? Constants.Labels.logIn : Constants.Labels.Continue)
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                            }
                            .disabled(viewModel.loginButtonDisabled())
                            .navigationDestination(isPresented: $viewModel.presentMainTabView, destination: {
                                MainTabView()
                            })
                            .navigationDestination(isPresented: $viewModel.showCreateProfileView, destination:  {
                                CreateProfileView(viewModel: viewModel)
                            })
                            .alert(isPresented: $viewModel.showAlert) {
                                Alert(
                                    title: Text(""), message: Text(viewModel.alertMessage),
                                    dismissButton: .default(Text(Constants.Labels.ok)
                                        .foregroundColor(Constants.Colors.blueThemeColor)))
                            }
                            
                            //MARK: LINK TO SHIFT TO LOGIN VIEW OR VICE-VERSA
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
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

