//
//  OtpView.swift
//  EventPlanner
//
//  Created by Chicmic on 01/06/23.
//

import SwiftUI

struct OtpView: View {
    
    @ObservedObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(Constants.Labels.enterOtp)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 40)
                
                TextFieldView(placeholder: Constants.Labels.Placeholders.otp, text: $viewModel.otp)
                
                Text(Constants.Labels.otpMessage)
                    .fontWeight(.semibold)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                
                HStack {
                    if viewModel.secondsRemaining != 0 {
                        Text("Resend OTP in: \(viewModel.secondsRemaining)s")
                    }
                    else {
                        Button(Constants.Labels.resendOtp) {
                            //viewModel.resendOtp()
                        }
                    }
                }
                .padding(.bottom)
                
                Button {
                    viewModel.verifyOtp()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(viewModel.otpButtonDisabled() ? .gray : Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text(Constants.Labels.verify)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(viewModel.otpButtonDisabled())
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text(""), message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text(Constants.Labels.ok)
                            .foregroundColor(Constants.Colors.blueThemeColor)))
                }
                
                NavigationLink(destination: ResetPasswordView(viewModel: viewModel), isActive: $viewModel.presentResetPasswordView) {
                    EmptyView()
                }
                .hidden()
                
                Spacer()
            }
            .onAppear {
                viewModel.startTimer()
            }
            .padding()
            .padding(.top, 30)
            
            if viewModel.verifyOtpLoading {
                LoadingView()
            }
        }
    }
}

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView(viewModel: ForgotPasswordViewModel())
    }
}
