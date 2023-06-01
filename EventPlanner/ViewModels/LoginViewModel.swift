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
    @Published var isLoading: Bool = false
    @Published var presentMainTabView: Bool = false
    @Published var isLoggedIn = false
    @Published var showForgotPasswordSheet = false
   
    func showEmailWarning() -> Bool {
        return !Validations.shared.isValidEmail(email) && !email.isEmpty
    }
    
    func showPasswordWarning() -> Bool {
        return !Validations.shared.isValidPassword(password) && !password.isEmpty
    }
    
    func loginButtonDisabled() -> Bool {
        return showEmailWarning() || showPasswordWarning() || email.isEmpty || password.isEmpty
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
        
        UserDefaults.standard.set(true, forKey: Constants.Labels.userLoggedIn)
        UserDefaults.standard.set(false, forKey: Constants.Labels.guestLoginKey)
        // show progress view until the function completes
        // if call is successful, go to the main tab view (toggle the 'presentMainView' boolean), else show the appropriate message to the user
        // handle the case if the user is already logged in as a guest
        // if call is successful, there are two cases
        // 1. user is already loggedin as a guest
        //    make the userdefault of the guestloginkey to false
        // 2. user is not already logged in as a guest
        //    make the userdefault of the guestloginkey to false
        //    load the main tab view afresh
        // if user is entered successfully, store the status in the user defaults also
    }
    
    func loginGuest() {
        // store in the user defaults that the user is logged in as a guest in the app
        UserDefaults.standard.set(true, forKey: Constants.Labels.guestLoginKey)
        // toggle 'presentMainView' boolean
        presentMainTabView.toggle()
    }
}
