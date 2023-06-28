//
//  LoginViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    //MARK: PROPERTIES
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    @Published var isLoginView: Bool = true
    @Published var presentMainTabView: Bool = false
    @Published var isLoggedIn = false
    @Published var showForgotPasswordSheet = false
    @Published var showAlert = false
    @Published var alertMessage = Constants.Labels.Alerts.alertMessage
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
    
    
    //MARK: METHODS
   
    
    /// this method decides whether to show the email warning in the view or not by checking whether is email is empty or not and validating it using the validations singleton method.
    ///
    /// - Returns: true if the warning is needed to be shown to the user, and false otherwise.
    ///
    func showEmailWarning() -> Bool {
        return !Validations.shared.isValidEmail(email) && !email.isEmpty
    }
    
    /// this method decides whether or not to show the password warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showPasswordWarning() -> Bool {
        let bool = !Validations.shared.isValidPassword(password) && !password.isEmpty
        if isLoginView {
            return bool
        }
        else {
            return bool  || !(password == confirmPassword)
        }
    }
    
    /// this method decides whether the login button is disabled or not.
    ///
    /// - Returns: true if the button is needed to be disabled and false otherwise.
    ///
    func loginButtonDisabled() -> Bool {
        return showEmailWarning() || showPasswordWarning() || email.isEmpty || password.isEmpty
    }
    
    /// this method decides whether or not to show the first name warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showFirstNameWarning() -> Bool {
        return !Validations.shared.isValidFirstName(self.firstName) && !self.firstName.isEmpty
    }
    
    /// this method decides whether or not to show the last name warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showLastNameWarning() -> Bool {
        return !Validations.shared.isValidLastName(self.lastName) && !self.lastName.isEmpty
    }
    
    /// this method decides whether or not to show the phone number warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showPhoneNumberWarning() -> Bool {
        return !Validations.shared.isValidPhoneNumber(self.phoneNumber) && !self.phoneNumber.isEmpty
    }
    
    /// this method decides whether or not to show the date of birth warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showDobWarning() -> Bool {
        return !Validations.shared.isValidDob(self.dob) && !self.dob.isEmpty
    }

    
    /// this method  calls the API method for login or signup depending upon the action performed by the user.
    ///
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
