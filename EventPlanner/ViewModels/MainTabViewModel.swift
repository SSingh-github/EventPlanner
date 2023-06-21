//
//  MainTabViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import Foundation
import CoreLocation

class MainTabViewModel: ObservableObject {

    @Published var guestLogin = UserDefaults.standard.bool(forKey: Constants.Labels.guestLoginKey)
    @Published var userLogin = UserDefaults.standard.bool(forKey: Constants.Labels.userLoggedIn)
    @Published var showWelcomeViewModel = false
    @Published var showEditProfileView = false
    @Published var selectionIndex = 0
    @Published var showEditEventSheet = false
    @Published var eventForEdit: Event?

    
    @Published var firstName = "first name"
    @Published var lastName = "last name"
    @Published var dob = ""
    @Published var dateOfBirth = Date()
    @Published var address = "mohali"
    @Published var phoneNumber = "9999999999"
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

    
    @Published var newEvent: NewEvent = NewEvent()
    @Published var newEventForEdit: NewEvent = NewEvent()
    @Published var actionType: EventActionType = .createEvent
    @Published var showEditSheet = false
    
    @Published var postingNewEvent = false
//    @Published var showAlert = false
//    @Published var alertMessage = ""
    @Published var selected = "Start"
    @Published var selectionIndex2 = 0

    
    let startDate2 = Calendar.current.date(from: DateComponents(year: 1930, month: 1, day: 1))!
    let endDate2 = Calendar.current.date(from: DateComponents(year: 2005, month: 1, day: 1))!

    
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
    
    func followUser(id: Int) {
        NetworkManager.shared.followUser(userId: id)
    }
    
    func joinEvent(id: Int) {
        NetworkManager.shared.joinEvent(eventId: id)
    }
    
    func createNewEventForEdit(event: Event) {
        self.newEventForEdit.selectedOption = Constants.Labels.eventTypes[event.event_category_id - 1]
        self.newEventForEdit.title = event.title
        self.newEventForEdit.description = event.description
        self.newEventForEdit.hashtags = event.hashtags
        self.newEventForEdit.startDate = Formatter.shared.createDateFromString(date: event.start_date)!
        self.newEventForEdit.endDate = Formatter.shared.createDateFromString(date: event.end_date)!
        //for location, if the user edits the location then the fields will not be nil
        //if the user does not edits the location, then the fields will be nil and you can use the location and coordinates parameters of eventForEdit
    }
    
    func printData() {
        print("selected option is \(self.newEvent.selectedOption ?? "")")
        print("title is \(self.newEvent.title)")
        print("description is \(self.newEvent.description)")
        print("hashtags \(self.newEvent.hashtags)")
        print("dates are \(self.newEvent.formattedStartDate) and \(self.newEvent.formattedEndDate)")
        print("times are \(self.newEvent.formattedStartTime) and \(self.newEvent.formattedEndTime)")
        print("location is \(self.newEvent.pickedMark?.name ?? "") + \(self.newEvent.pickedMark?.locality ?? "") + \(self.newEvent.pickedMark?.subLocality ?? "")")
        print("coordinates are \(self.newEvent.pickedLocation?.coordinate.latitude ?? 0.0), \(self.newEvent.pickedLocation?.coordinate.longitude ?? 0.0)")
    }
    
    func postNewEvent(viewModel: MainTabViewModel, appState: AppState) {
        let formattedDates = Formatter.shared.formatDate(dates: [self.newEvent.startDate, self.newEvent.endDate])
        let formattedTimes = Formatter.shared.formatTime(times: [self.newEvent.startDate, self.newEvent.endDate])
        self.newEvent.formattedStartDate = formattedDates[0]
        self.newEvent.formattedEndDate = formattedDates[1]
        self.newEvent.formattedStartTime = formattedTimes[0]
        self.newEvent.formattedEndTime = formattedTimes[1]
        self.postingNewEvent = true
        NetworkManager.shared.postNewEvent(viewModel: self, appState: appState)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewModel.shiftTabToMyEvents()
        }
    }
    
    func updateEvent() {
        let formattedDates = Formatter.shared.formatDate(dates: [self.newEventForEdit.startDate, self.newEventForEdit.endDate])
        let formattedTimes = Formatter.shared.formatTime(times: [self.newEventForEdit.startDate, self.newEventForEdit.endDate])
        self.newEventForEdit.formattedStartDate = formattedDates[0]
        self.newEventForEdit.formattedEndDate = formattedDates[1]
        self.newEventForEdit.formattedStartTime = formattedTimes[0]
        self.newEventForEdit.formattedEndTime = formattedTimes[1]
        
        NetworkManager.shared.updateEvent(viewModel: self)
    }
}
