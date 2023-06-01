//
//  ForgotPasswordViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 01/06/23.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var otp = ""
    @Published var presentOtpView = false
    @Published var presentResetPasswordView = false
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var secondsRemaining = 180
    @Published var timer: Timer?
    
    func showEmailWarning() -> Bool {
        return !Validations.shared.isValidEmail(email) && !email.isEmpty
    }
    
    func showPasswordWarning() -> Bool {
        return !Validations.shared.isValidPassword(newPassword) && !newPassword.isEmpty
    }
    
    func showConfirmPasswordWarning() -> Bool {
        return self.newPassword != self.confirmPassword && !self.confirmPassword.isEmpty
    }
    
    func buttonDisabled() -> Bool {
        return showEmailWarning() || email.isEmpty
    }
    
    func otpButtonDisabled() -> Bool {
        return otp.count != 4 || secondsRemaining == 0
    }
    
    func resetPasswordButtonDisabled() -> Bool {
        return showPasswordWarning() || newPassword.isEmpty || confirmPassword.isEmpty || newPassword != confirmPassword
    }
    
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
    
    func resendOtp() {
        //this function will send the request to resend the otp
        
        self.secondsRemaining = 180
        startTimer()
    }
}
