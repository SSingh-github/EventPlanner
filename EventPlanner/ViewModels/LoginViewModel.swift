//
//  LoginViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isLoginView: Bool = false
    @Published var presentMainTabView: Bool = false
    @Published var isLoggedIn = false
    @Published var showForgotPasswordSheet = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showCreateProfileView = false
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var dob = ""
    @Published var dateOfBirth = Date()
    @Published var address = ""
    @Published var phoneNumber = ""
    @Published var imagePicker = ImagePicker()
    
    let startDate = Calendar.current.date(from: DateComponents(year: 1930, month: 1, day: 1))!
    let endDate = Calendar.current.date(from: DateComponents(year: 2005, month: 1, day: 1))!
   
    func showEmailWarning() -> Bool {
        return !Validations.shared.isValidEmail(email) && !email.isEmpty
    }
    
    func showPasswordWarning() -> Bool {
        return !Validations.shared.isValidPassword(password) && !password.isEmpty
    }
    
    func loginButtonDisabled() -> Bool {
        return showEmailWarning() || showPasswordWarning() || email.isEmpty || password.isEmpty
    }
    
    func showFirstNameWarning() -> Bool {
        return !Validations.shared.isValidFirstName(self.firstName) && !self.firstName.isEmpty
    }
    
    func showLastNameWarning() -> Bool {
        return !Validations.shared.isValidLastName(self.lastName) && !self.lastName.isEmpty
    }
    
    func showPhoneNumberWarning() -> Bool {
        return !Validations.shared.isValidPhoneNumber(self.phoneNumber) && !self.phoneNumber.isEmpty
    }
    
    func showDobWarning() -> Bool {
        return !Validations.shared.isValidDob(self.dob) && !self.dob.isEmpty
    }

    
    func buttonClicked() {
        
        isLoggedIn = true
        
        let user: UserCredentials = UserCredentials(email: self.email, password: self.password)
        
        if isLoginView {
            NetworkManager.shared.logInCall(for: user, viewModel: self)
        }
        else {
            NetworkManager.shared.signUpCall(for: user, viewModel: self)
        }
    }
    
    func loginGuest() {
        UserDefaults.standard.set(true, forKey: Constants.Labels.guestLoginKey)
        presentMainTabView.toggle()
    }
    
    
}
