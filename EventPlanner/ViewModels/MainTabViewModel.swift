//
//  MainTabViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import Foundation
import CoreLocation

class MainTabViewModel: ObservableObject {
    
    //MARK: PROPERTIES
    
    @Published var guestLogin = UserDefaults.standard.bool(forKey: Constants.Labels.guestLoginKey)
    @Published var userLogin = UserDefaults.standard.bool(forKey: Constants.Labels.userLoggedIn)
    @Published var showWelcomeViewModel = false
    @Published var showEditProfileView = false
    @Published var selectionIndex = 0
    @Published var showEditEventSheet = false
    @Published var eventForEdit: Event?
    @Published var isActive: Bool = false
    @Published var showCreateEventAlert = false
    @Published var showMyEventsAlert = false
    @Published var showFavEventsAlert = false
    @Published var showJoinedEventsAlert = false
    @Published var showEditEventActionSheet = false
    @Published var dateOfBirth: Date? = nil
    @Published var userProfile: UserDataDetails = UserDataDetails()
    @Published var userProfileLoading = false
    @Published var isLoggedOut = false
    @Published var showAlert = false
    @Published var alertMessage = Constants.Labels.Alerts.alertMessage
    @Published var showSignoutAlert = false
    @Published var imagePicker = ImagePicker()
    @Published var editProfileLoading = false
    @Published var selection: Tab = .explore
    @Published var checks = [false, false, false, false, false, false]
    @Published var detailedEventForExplore: DetailedEvent?
    @Published var showDetailedEventForExplore = true
    @Published var showDetialedEventForMyEvents = false
    @Published var events: [Event] = []
    @Published var myEvents: [Event] = []
    @Published var favouriteEvents: [Event] = []
    @Published var joinedEvents: [Event] = []
    @Published var showFilterView = false
    @Published var filter: Filter = Filter()
    @Published var showActionSheet = false
    @Published var showLocationView = false
    @Published var newEvent: NewEvent = NewEvent()
    @Published var newEventForEdit: NewEvent = NewEvent()
    @Published var actionType: EventActionType = .createEvent
    @Published var showEditSheet = false
    @Published var postingNewEvent = false
    @Published var selected = Constants.Labels.start
    @Published var selectionIndex2 = 0
    @Published var createdEventsLoading = false
    @Published var favouriteEventsLoading = false
    @Published var joinedEventsLoading = false
    @Published var showJoinEventActionSheet = false
    @Published var showMap = false
    @Published var navigate = false
    @Published var showEditProfileActionSheet = false
    @Published var showDeleteAlert = false
    @Published var index: Int = 0
    @Published var startDate2 = Calendar.current.date(from: DateComponents(year: 1930, month: 1, day: 1))!
    @Published var endDate2 = Calendar.current.date(from: DateComponents(year: 2005, month: 1, day: 1))!
    
    //MARK: COMPUTED PROPERTIES
    var buttonDisabled: Bool {
        var bool: Bool = false
        bool = bool || self.userProfile.first_name.isEmpty
        bool = bool || self.userProfile.last_name.isEmpty
        bool = bool || self.userProfile.phone_number.isEmpty
        bool = bool || self.userProfile.address.isEmpty
        bool = bool || self.dateOfBirth == nil
        bool = bool || self.showFirstNameWarning()
        bool = bool || self.showLastNameWarning()
        bool = bool || self.showPhoneNumberWarning()
        return bool
    }
    
    var dateButtonDisabled: Bool {
        if actionType == .createEvent {
            return newEvent.startTime == nil || newEvent.endTime == nil
        }
        else {
            return newEventForEdit.startTime == nil || newEventForEdit.endTime == nil
        }
    }
    
    func isTimeDifferenceAtLeastOneHour(date1: Date, date2: Date) -> Bool {
        let timeInterval = date2.timeIntervalSince(date1)
        let hourInSeconds: TimeInterval = 3600
        
        return timeInterval >= hourInSeconds
    }
    
    
    var filterButtonDisabled : Bool {
        var bool: Bool = false
        for check in self.checks {
            bool = bool || check
        }
        if checks[0] && self.filter.eventCategory == nil || checks[1] && self.filter.startDate == nil {
            return true
        }
        else if checks[2] && self.filter.title.isEmpty || checks[3] && self.filter.hashtag.isEmpty || checks[5] && self.filter.location.isEmpty {
            return true
        }
        return !bool
    }
    
    var buttonDisabled2: Bool {
        if self.actionType == .createEvent {
            var bool: Bool = false
            bool = bool || self.newEvent.title.isEmpty
            bool = bool || self.newEvent.hashtags.isEmpty
            bool = bool || self.newEvent.selectedOption == nil
            bool = bool || self.newEvent.imagePicker2.image == nil
            
            if !self.newEvent.hashtags.isEmpty {
                for hashtag in self.newEvent.hashtags {
                    if hashtag.isEmpty {
                        return true
                    }
                }
            }
            
            return bool
        }
        else {
            var bool: Bool = false
            bool = bool || self.newEventForEdit.title.isEmpty
            bool = bool || self.newEventForEdit.hashtags.isEmpty
            bool = bool || self.newEventForEdit.selectedOption == nil
            bool = bool || self.newEventForEdit.imagePicker2.image == nil
            
            if !self.newEventForEdit.hashtags.isEmpty {
                for hashtag in self.newEventForEdit.hashtags {
                    if hashtag.isEmpty {
                        return true
                    }
                }
            }
            return bool
        }
    }
    
   
    //MARK: METHODS
    
    ///This method creates the hashtag string from the array of hashtags to represent in the event details view
    ///
    /// - Returns: the string representing the combination of hashtags
    ///
    func getHashtagString()-> String {
        if let detailedEvent = detailedEventForExplore{
            var string = ""
            for hashtag in detailedEvent.hashtags {
                string += hashtag + " "
            }
            return string
        }
        return Constants.Labels.noHashtags
    }
    
    /// This method calls the method in the network manager to fetch the user profile details
    ///
    func getProfile() {
        self.userProfileLoading = true
        NetworkManager.shared.getUserProfileDetails(viewModel: self)
    }
    
    /// This method calls the sign out method in the network manager to sign out the user
    ///
    func signOutCall(appState: AppState) {
        self.isLoggedOut = true
        NetworkManager.shared.signOutCall(viewModel: self, appState: appState)
        
    }
    
    /// This method decides whether or not to show the first name warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showFirstNameWarning() -> Bool {
        return !Validations.shared.isValidFirstName(self.userProfile.first_name) && !self.userProfile.first_name.isEmpty
    }
    
    /// This method decides whether or not to show the last name warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showLastNameWarning() -> Bool {
        return !Validations.shared.isValidLastName(self.userProfile.last_name) && !self.userProfile.last_name.isEmpty
    }
    
    /// This method decides whether or not to show the phone number warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showPhoneNumberWarning() -> Bool {
        return !Validations.shared.isValidPhoneNumber(self.userProfile.phone_number) && !self.userProfile.phone_number.isEmpty
    }
    
    /// This method decides whether or not to show the date of birth warning to the user.
    ///
    /// - Returns: true if the warning is needed to be shown to the user and false otherwise.
    ///
    func showDobWarning() -> Bool {
        return !Validations.shared.isValidDob(self.userProfile.dob) && !self.userProfile.dob.isEmpty
    }
    
    /// This method calls the update profile method in the network manager
    ///
    func updateUserProfile() {
        self.editProfileLoading = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringFormats.dateFormat
        self.userProfile.dob = dateFormatter.string(from: self.dateOfBirth!)
        
        NetworkManager.shared.updateUserProfileDetails(viewModel: self)
    }
    
    /// This helper method shifts the tab of the main tab view to my-events tab
    ///
    func shiftTabToMyEvents() {
        self.selection = .myEvents
    }
    
    /// This method calls the get events method in the network manager to fetch all the events which are meant for the user
    ///
    func getEventList() {
        NetworkManager.shared.getEvents(viewModel: self)
    }
    
    /// This method calls the getMyEvents method in the network managar to fetch all the events which were created by the user.
    ///
    func getMyEvents() {
        self.createdEventsLoading = true
        NetworkManager.shared.getMyEvents(viewModel: self)
    }
    
    /// This method calls the getJoinedEvents method in the network manager to fetch all the events which were joined by the user
    ///
    func getJoinedEvents() {
        self.joinedEventsLoading = true
        NetworkManager.shared.getJoinedEvents(viewModel: self)
    }
    
    /// This method calls the method in the network manager to fetch all the events which are marked favourite by the user
    ///
    func getFavouriteEvents() {
        self.favouriteEventsLoading = true
        NetworkManager.shared.getFavouriteEvents(viewModel: self)
    }
    
    /// This method resets the filter object
    ///
    func resetFilter() {
        self.filter = Filter()
        self.checks = [false, false, false, false, false, false]
    }
    
    /// This method calls the method in the network manger to fetch all the filtered events depending upon the filter applied by the user
    ///
    func getFilteredEvents() {
        NetworkManager.shared.getFilteredEvents(viewModel: self)
    }
    
    /// This method calls the delete event function in the network manager and then calls the get my events method to get the updated events
    ///
    ///  - Parameters:
    ///     - id: represents the ID of the event to be deleted.
    ///
    func deleteEvent(id: Int) {
        NetworkManager.shared.deleteEvent(eventId: id)
        NetworkManager.shared.getMyEvents(viewModel: self)
    }
    
    /// This method calls the follow user method to follow the user with the given ID.
    ///
    /// - Parameters:
    ///    - id : represents the ID of the user which the user intends to follow.
    ///
    func followUser(id: Int) {
        NetworkManager.shared.followUser(userId: id)
    }
    
    /// This method calls the join event function in the network manager
    ///
    /// - Parameters:
    ///    - id : represents the ID of the event the user intends to join.
    ///
    func joinEvent(id: Int) {
        NetworkManager.shared.joinEvent(eventId: id)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getJoinedEvents()
        }
    }
    
    
    ///   This method likes the event with the given id
    /// - Parameter id: The integer id of the event.
    ///
    func likeEvent(id: Int) {
        NetworkManager.shared.likeTheEvent(eventId: id)
    }
    
    
    /// This method marks the event with the particular as the favourite event for the user
    /// - Parameter id: The integer id of the event.
    ///
    func markEventFav(id: Int) {
        NetworkManager.shared.markEventAsFavourite(eventId: id)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getFavouriteEvents()
        }
    }
    
    /// This method initializes the newEventForEdit object with the values of the event
    ///
    /// - Parameters:
    ///    - event: represent the current event the user is intented to update.
    ///
    func createNewEventForEdit(event: Event) {
        self.newEventForEdit.selectedOption = Constants.Labels.eventTypes[event.event_category_id - 1]
        self.newEventForEdit.title = event.title
        self.newEventForEdit.description = event.description
        self.newEventForEdit.hashtags = event.hashtags
        self.newEventForEdit.startDate = Formatter.shared.createDateFromString(date: event.start_date)!
        self.newEventForEdit.endDate = Formatter.shared.createDateFromString(date: event.end_date)!
    }
    
    /// This method calls the postNewEvent in the network manager which posts the new event created by the user.
    ///
    /// - Parameters:
    ///    - viewModel: represents the reference of current view model which is then further passed to the function call in the network manager.
    ///    - appState: represents the instance of the AppState object which is then further passed to the function call in the network manager.
    ///
    func postNewEvent(viewModel: MainTabViewModel, appState: AppState) {
        let formattedDates = Formatter.shared.formatDate(dates: [self.newEvent.startDate, self.newEvent.endDate])
        let formattedTimes = Formatter.shared.formatTime(times: [self.newEvent.startTime!, self.newEvent.endTime!])
        self.newEvent.formattedStartDate = formattedDates[0]
        self.newEvent.formattedEndDate = formattedDates[1]
        self.newEvent.formattedStartTime = formattedTimes[0]
        self.newEvent.formattedEndTime = formattedTimes[1]
        self.postingNewEvent = true
        NetworkManager.shared.postNewEvent(viewModel: self, appState: appState)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getMyEvents()
        }
    }
    
    /// This method calls the update event method in the network manager and updates the event.
    ///
    func updateEvent() {
        let formattedDates = Formatter.shared.formatDate(dates: [self.newEventForEdit.startDate, self.newEventForEdit.endDate])
        let formattedTimes = Formatter.shared.formatTime(times: [self.newEventForEdit.startTime!, self.newEventForEdit.endTime!])
        self.newEventForEdit.formattedStartDate = formattedDates[0]
        self.newEventForEdit.formattedEndDate = formattedDates[1]
        self.newEventForEdit.formattedStartTime = formattedTimes[0]
        self.newEventForEdit.formattedEndTime = formattedTimes[1]
        NetworkManager.shared.updateEvent(viewModel: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getMyEvents()
            self.getJoinedEvents()
        }
    }
    
    /// This method calls the event details method depending upon the event type and the index of event.
    ///
    /// - Parameters:
    ///    - eventType: this represents the value of enum EventType which is then used to identify the event in the array of corresponding type.
    ///    - indexOfEvent: this represents the index of event in the array containing the events of given type.
    ///    
    func getEventDetails(eventType: EventType, indexOfEvent: Int) {
        self.showDetailedEventForExplore = true
        if eventType == .all {
            NetworkManager.shared.eventDetails(viewModel: self, eventId: self.events[indexOfEvent].id)
        }
        else if eventType == .created {
            NetworkManager.shared.eventDetails(viewModel: self, eventId: self.myEvents[indexOfEvent].id)
        }
        else if eventType == .favourite {
            NetworkManager.shared.eventDetails(viewModel: self, eventId: self.favouriteEvents[indexOfEvent].id)
        }
        else if eventType == .joined {
            NetworkManager.shared.eventDetails(viewModel: self, eventId: self.joinedEvents[indexOfEvent].id)
        }
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
    
}
