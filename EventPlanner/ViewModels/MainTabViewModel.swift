//
//  MainTabViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import Foundation

class MainTabViewModel: ObservableObject {

    @Published var guestLogin = UserDefaults.standard.bool(forKey: Constants.Labels.guestLoginKey)
    @Published var userLogin = UserDefaults.standard.bool(forKey: Constants.Labels.userLoggedIn)
    @Published var showWelcomeViewModel = false
    @Published var showEditProfileView = false
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var dob = ""
    @Published var formattedDateOfBirth = ""
    @Published var address = ""
    @Published var phoneNumber = ""
    @Published var isLoggedOut = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showSignoutAlert = false
    @Published var imagePicker = ImagePicker()
    @Published var editProfileLoading = false
    
    func signOutCall() {
        self.isLoggedOut = true
        NetworkManager.shared.signOutCall(viewModel: self)
        
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
    
    func updateUserProfile() {
        self.editProfileLoading = true
        NetworkManager.shared.updateUserProfileDetails(viewModel: self)
    }
}
