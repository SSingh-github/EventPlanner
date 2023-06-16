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
    
    @Published var firstName = "first name"
    @Published var lastName = "last name"
    @Published var dob = ""
    @Published var dateOfBirth = Date()
    @Published var address = "mohali"
    @Published var phoneNumber = "0000000000"
    @Published var imageUrl = ""

    @Published var userProfile: UserDataDetails = UserDataDetails(dob: "0000-00-00", phone_number: 0000000000, address: "", first_name: "first name", last_name: "last name", profile_image: "")
    
    @Published var isLoggedOut = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showSignoutAlert = false
    @Published var imagePicker = ImagePicker()
    @Published var editProfileLoading = false
    @Published var selection: Tab = .explore
    @Published var checks = [false, false, false, false, false, false]
    @Published var detailedEventForExplore: DetailedEvent? // detailed event object for explore view
    @Published var detailedEventForMyEvents: DetailedEvent? // detialed event object for my events view
    @Published var showDetailedEventForExplore = true
    @Published var showDetialedEventForMyEvents = false
    @Published var events: [Event] = []
    @Published var myEvents: [Event] = []
    @Published var favouriteEvents: [Event] = []
    @Published var joinedEvents: [Event] = []
    @Published var showFilterView = false
    @Published var filter: Filter = Filter(eventCategory: "", startDate: Date(), hashtag: "", title: "", radius: 5.0, location: "")

    
    let startDate = Calendar.current.date(from: DateComponents(year: 1930, month: 1, day: 1))!
    let endDate = Calendar.current.date(from: DateComponents(year: 2005, month: 1, day: 1))!

    
    func getHashtagString()-> String {
        if let detailedEvent = detailedEventForExplore{
            var string = ""
            for hashtag in detailedEvent.hashtags {
                string += hashtag + " "
            }
            return string
        }
        return "no hashtags"
    }
    
    func signOutCall() {
        self.isLoggedOut = true
        NetworkManager.shared.signOutCall(viewModel: self)
        
    }
    
    func showFirstNameWarning() -> Bool {
        return !Validations.shared.isValidFirstName(self.userProfile.first_name) && !self.userProfile.first_name.isEmpty
    }
    
    func showLastNameWarning() -> Bool {
        return !Validations.shared.isValidLastName(self.userProfile.last_name) && !self.userProfile.last_name.isEmpty
    }
    
    func showPhoneNumberWarning() -> Bool {
        return !Validations.shared.isValidPhoneNumber(self.phoneNumber) && !self.phoneNumber.isEmpty
    }
    
    func showDobWarning() -> Bool {
        return !Validations.shared.isValidDob(self.userProfile.dob) && !self.userProfile.dob.isEmpty
    }
    
    func updateUserProfile() {
        self.editProfileLoading = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringFormats.dateFormat
        self.dob = dateFormatter.string(from: self.dateOfBirth)
        
        NetworkManager.shared.updateUserProfileDetails(viewModel: self)
    }
    
    func shiftTabToMyEvents() {
        self.selection = .myEvents
    }
    
    func getEventList() {
        NetworkManager.shared.getEvents(viewModel: self)
    }
    
    func getMyEvents() {
        NetworkManager.shared.getMyEvents(viewModel: self)
    }
    
    func getJoinedEvents() {
        NetworkManager.shared.getJoinedEvents(viewModel: self)
    }
    
    func getFavouriteEvents() {
        NetworkManager.shared.getFavouriteEvents(viewModel: self)
    }
    
    func resetFilter() {
        self.filter = Filter(eventCategory: "", startDate: Date(), hashtag: "", title: "", radius: 0.0, location: "")
    }
    
    func getFilteredEvents() {
        NetworkManager.shared.getFilteredEvents(viewModel: self)
    }
    
    func deleteEvent(id: Int) {
        NetworkManager.shared.deleteEvent(eventId: id)
        NetworkManager.shared.getMyEvents(viewModel: self)
    }
}
