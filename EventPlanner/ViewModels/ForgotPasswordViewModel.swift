//
//  ForgotPasswordViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 01/06/23.
//

import Foundation
import CoreLocation

class ForgotPasswordViewModel: ObservableObject {
    
    //MARK: PROPERTIES
    
    @Published var email = ""
    @Published var otp = ""
    @Published var presentOtpView = false
    @Published var presentResetPasswordView = false
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var secondsRemaining = 180
    @Published var timer: Timer?
    @Published var forgotPasswordLoading = false
    @Published var verifyOtpLoading = false
    @Published var resetPasswordLoading = false
    @Published var showLoginView = false
    @Published var resetPasswordSuccessful = false
    @Published var showAlert = false
    @Published var alertMessage = Constants.Labels.Alerts.alertMessage
    
    
    //MARK: METHODS
    
    /// This method decides whether to show the email warning in the view or not by checking whether is email is empty or not and validating it using the validations singleton method.
    ///
    /// - Returns: true if the warning is needed to be shown to the user, and false otherwise.
    ///
    func showEmailWarning() -> Bool {
        return !Validations.shared.isValidEmail(email) && !email.isEmpty
    }
    
    /// This method decides whether to show the password warning in the view or not by checking whether is password is empty or not and validating it using the validations singleton method.
    ///
    /// - Returns: true if the warning is needed to be shown to the user, and false otherwise.
    ///
    func showPasswordWarning() -> Bool {
        return !Validations.shared.isValidPassword(newPassword) && !newPassword.isEmpty
    }
    
    /// This method decides whether to show the confirm-password warning in the view or not by checking whether is confirm-password  is empty or not and validating it using the validations singleton method.
    ///
    /// - Returns: true if the warning is needed to be shown to the user, and false otherwise.
    ///
    func showConfirmPasswordWarning() -> Bool {
        return self.newPassword != self.confirmPassword && !self.confirmPassword.isEmpty
    }
    
    /// This method decides whether the button is disabled in the view or not depending upon the email vaildity.
    ///
    /// - Returns: true if the button is needed to be disabled and false otherwise.
    ///
    func buttonDisabled() -> Bool {
        return showEmailWarning() || email.isEmpty
    }
    
    /// This method decides whether the otp button is disabled in view or not depending upon the validity of the otp entered and the time remaining for entering the otp.
    ///
    /// - Returns: true if the button is needed to be disabled and false otherwise.
    ///
    func otpButtonDisabled() -> Bool {
        return otp.count != 4 || secondsRemaining == 0
    }
    
    /// This method decides whether the reset password button should be disabled or not.
    ///
    ///- Returns: true if the button is needed to be disabled and false otherwise.
    ///
    func resetPasswordButtonDisabled() -> Bool {
        return showPasswordWarning() || newPassword.isEmpty || confirmPassword.isEmpty || newPassword != confirmPassword
    }
    
    /// This method starts the timer for 180 seconds
    ///
    func startTimer() {
        self.secondsRemaining = 180
        
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
            } else {
                self.timer?.invalidate()
            }
        }
    }
    
    /// this method calls the resend otp method in the network manager and initializes the timer to 180 seconds.
    ///
    func resendOtp() {
        self.secondsRemaining = 180
        startTimer()
        NetworkManager.shared.resendOtp(viewModel: self)
    }
    
    /// this method calls the forgot password method in the network manager
    ///
    func forgotPassword() {
        self.forgotPasswordLoading = true
        NetworkManager.shared.forgotPassword(viewModel: self)
    }
    
    /// this method calls the verify otp method in the network manager
    ///
    func verifyOtp() {
        self.verifyOtpLoading = true
        NetworkManager.shared.verifyOtp(viewModel: self)
    }
    
    /// this method calls the reset password method in the network manager
    /// 
    func resetPassword(viewModel: LoginViewModel) {
        self.resetPasswordLoading = true
        NetworkManager.shared.resetPassword(viewModel: self, loginViewModel: viewModel)
    }
}
