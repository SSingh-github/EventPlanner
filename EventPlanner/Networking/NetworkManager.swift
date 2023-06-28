//
//  Network.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.

import Foundation
import UIKit


class NetworkManager {
    
    private init () {}
    
    //MARK: PROPERTIES
    static let shared = NetworkManager()
    
    var authorizationKey: String = ""
    
    //MARK: METHODS FOR API CALLS
    func signUpCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : userCredentials.email,
            Constants.Keys.password : userCredentials.password
        ]
        
        let request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.signUp, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: false, body: bodyData, isMultipart: false, image: nil)
        
        guard request != nil else {return}
        
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil) { httpResponse in
            if let authorizationKey = httpResponse.allHeaderFields[Constants.API.authorizationHeaderField] as? String {
                self.authorizationKey = authorizationKey
                UserDefaults.standard.set(self.authorizationKey, forKey: Constants.Labels.authToken)
                UserDefaults.standard.set(true, forKey: Constants.Labels.userLoggedIn)
                UserDefaults.standard.set(false, forKey: Constants.Labels.guestLoginKey)
                print(self.authorizationKey)
            }
        } failureCompletion: {
            DispatchQueue.main.async {
                viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                viewModel.showAlert = true
            }
        } completion: { data, response, error in
            do{
                let response = try JSONDecoder().decode(Response.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.code)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.createUserProfile(viewModel: viewModel)
        }
    }
    
    func logInCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : userCredentials.email,
            Constants.Keys.password : userCredentials.password
        ]
        
        let request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.logIn, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: false, body: bodyData, isMultipart: false, image: nil)
        
        guard request != nil else {return}
        
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.isLoggedIn = false
                    viewModel.showAlert.toggle()
                }
            }
        } successCompletion: { httpResponse in
            if let authorizationKey = httpResponse.allHeaderFields[Constants.API.authorizationHeaderField] as? String {
                self.authorizationKey = authorizationKey
                UserDefaults.standard.set(self.authorizationKey, forKey: Constants.Labels.authToken)
                print(self.authorizationKey)
            }
        } failureCompletion: {
            print("Error: Unexpected status code ")
        } completion: { data, response, error in
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.code)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                viewModel.isLoggedIn = false
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        print(httpResponse.statusCode)
                        viewModel.presentMainTabView.toggle()
                        UserDefaults.standard.set(true, forKey: Constants.Labels.userLoggedIn)
                        UserDefaults.standard.set(false, forKey: Constants.Labels.guestLoginKey)
                    }
                    else {
                        viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                        viewModel.showAlert = true
                    }
                }
            }
        }
    }
   
    func resendOtp(viewModel: ForgotPasswordViewModel) {
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : viewModel.email
        ]
        
        let request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.forgotPassword, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: false, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil) {
            DispatchQueue.main.async {
                viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                viewModel.showAlert = true
            }
            return
        } completion: { data, response, error in
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func forgotPassword(viewModel: ForgotPasswordViewModel) {
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : viewModel.email
        ]
        
        let request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.forgotPassword, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: false, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.forgotPasswordLoading = false
                    viewModel.showAlert.toggle()
                }
            }
            return
        } successCompletion: { _ in
            print("success")
        } failureCompletion: {
            print("failure")
        } completion: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                viewModel.forgotPasswordLoading = false
                if httpResponse.statusCode == 200 {
                    viewModel.presentOtpView.toggle()
                }
                else {
                    print(httpResponse.statusCode)
                    print("some error occured while forgot password request")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
    }
    
    func verifyOtp(viewModel: ForgotPasswordViewModel) {
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : viewModel.email,
            Constants.Keys.otp : viewModel.otp
        ]
        
        let request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.verifyOtp, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: false, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                viewModel.verifyOtpLoading = false
                if httpResponse.statusCode == 200 {
                    viewModel.presentResetPasswordView.toggle()
                }
                else {
                    print("some error occured when verifying the otp")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
    }
    
    func resetPassword(viewModel: ForgotPasswordViewModel, loginViewModel: LoginViewModel) {
        
        viewModel.resetPasswordSuccessful = false
        let bodyData: [String: Any] = [
            Constants.Keys.email: viewModel.email,
            Constants.Keys.password : viewModel.newPassword
        ]
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.resetPassword, httpMethod: Constants.API.HttpMethods.put, authTokenNeeded: false, body: bodyData, isMultipart: false, image: nil)
        
        guard request != nil else {return}
        
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }

            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                viewModel.resetPasswordLoading = false
                
                if httpResponse.statusCode == 200 {
                    print("password reset successful")
                    loginViewModel.showForgotPasswordSheet.toggle()
                }
                else {
                    print("some error occured while resetting the password")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
    }
    
    func signOutCall(viewModel: MainTabViewModel) {
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.logOut, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: true, body: nil, isMultipart: false, image: nil)
        
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.isLoggedOut = false
                    viewModel.showAlert.toggle()
                }
            }
            return
        } successCompletion: { _ in
            print("success")
        } failureCompletion: {
            print("failure")
        } completion: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                viewModel.isLoggedOut = false
                
                if httpResponse.statusCode == 200 {
                    viewModel.showWelcomeViewModel.toggle()
                    UserDefaults.standard.set(false, forKey: Constants.Labels.userLoggedIn)
                    UserDefaults.standard.set(false, forKey: Constants.Labels.guestLoginKey)
                }
                else {
                    print("some error occured while logout")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
    }
    
    func getUserProfileDetails(viewModel: MainTabViewModel) {
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.getProfile, httpMethod: Constants.API.HttpMethods.get, authTokenNeeded: true, body: nil, isMultipart: false, image: nil)
        
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.userProfileLoading = false
                    viewModel.showAlert.toggle()
                }
            }
            return
        } successCompletion: { _ in
            print("success")
        } failureCompletion: {
            print("failure")
        } completion: { data, response, error in
            do {
                print(data)
                let response = try JSONDecoder().decode(UserData.self, from: data)
                DispatchQueue.main.async {
                    viewModel.userProfileLoading = false
                    viewModel.userProfile.phone_number = response.data.phone_number
                    viewModel.userProfile.address = response.data.address
                    viewModel.userProfile.first_name = response.data.first_name
                    viewModel.userProfile.last_name = response.data.last_name
                    viewModel.userProfile.dob = response.data.dob
                    viewModel.userProfile.profile_image = response.data.profile_image ?? ""
                    viewModel.dateOfBirth = Formatter.shared.createDateFromString(date: response.data.dob)!
                }
                
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func updateUserProfileDetails(viewModel: MainTabViewModel) {
        
        viewModel.userProfile.dob = Formatter.shared.formatSingleDate(date: viewModel.dateOfBirth!)
        
        let fields: [String: Any] = [
            Constants.Keys.firstName : viewModel.userProfile.first_name,
            Constants.Keys.lastName : viewModel.userProfile.last_name,
            Constants.Keys.dob : viewModel.userProfile.dob,
            Constants.Keys.phoneNumber : viewModel.userProfile.phone_number,
            Constants.Keys.address : viewModel.userProfile.address
        ]
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.updateProfile, httpMethod: Constants.API.HttpMethods.put, authTokenNeeded: true, body: fields, isMultipart: true, image: viewModel.imagePicker.image)
        
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.editProfileLoading = false
                    viewModel.showAlert = true
                }
            }
            return
        } successCompletion: { _ in
            print("success")
        } failureCompletion: {
            print("failure")
        } completion: { data, response, error in
            do {
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print(response.message)
            }
            catch {
                print("error decoding the response")
            }
            guard let httpResponse = response as? HTTPURLResponse else {return}
            DispatchQueue.main.async {
                viewModel.editProfileLoading = false
                
                if httpResponse.statusCode == 200 {
                    print("profile was updated successfully")
                    viewModel.showEditProfileView.toggle()
                }
                else {
                    print("some error occured")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
    }
   
    func getEvents(viewModel: MainTabViewModel) {
        //you can create an object of location manager here to get the coordinates of the user
        // for trial purposes use static coordinates
        // Create a URLComponents object with your base URL
        var urlComponents = URLComponents(string: Constants.API.URLs.postEvent)!
        
        // Add query parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "user_latitude", value: "30.711214"),
            URLQueryItem(name: "user_longitude", value: "76.690276")
            // Add more query items as needed
        ]
        
        // Create a URL from the URLComponents
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.get
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        if UserDefaults.standard.bool(forKey: Constants.Labels.guestLoginKey) == false {
            request.addValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        }
        NetworkHelper.shared.performRequest(request: request, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do {
                let response = try JSONDecoder().decode(EventData.self, from: data)
                DispatchQueue.main.async {
                    viewModel.events = response.data
                }
                for event in response.data {print(event.location)}
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func getMyEvents(viewModel: MainTabViewModel) {
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.myEvents, httpMethod: Constants.API.HttpMethods.get, authTokenNeeded: true, body: nil, isMultipart: false, image: nil)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.createdEventsLoading = false
                    viewModel.showMyEventsAlert.toggle()
                }
            }
            return
        } successCompletion: { _ in
            print("")
        } failureCompletion: {
            print("")
        } completion: { data, response, error in
            do {
                let response = try JSONDecoder().decode(EventData.self, from: data)
                
                DispatchQueue.main.async {
                    viewModel.myEvents = response.data
                    viewModel.createdEventsLoading = false
                }
                for event in response.data {print(event.location)}
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func getJoinedEvents(viewModel: MainTabViewModel) {
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.joinedEvents, httpMethod: Constants.API.HttpMethods.get, authTokenNeeded: true, body: nil, isMultipart: false, image: nil)
        
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.joinedEventsLoading = false
                    viewModel.showJoinedEventsAlert.toggle()
                }
            }
            return
        } successCompletion: { _ in
            print("")
        } failureCompletion: {
            print("")
        } completion: { data, response, error in
            do {
                let response = try JSONDecoder().decode(EventData.self, from: data)
                
                DispatchQueue.main.async {
                    viewModel.joinedEvents = response.data
                    viewModel.joinedEventsLoading = false
                }
                for event in response.data {print(event.location)}
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func getFavouriteEvents(viewModel: MainTabViewModel) {
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.favouriteEvents, httpMethod: Constants.API.HttpMethods.get, authTokenNeeded: true, body: nil, isMultipart: false, image: nil)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.favouriteEventsLoading = false
                    viewModel.showFavEventsAlert.toggle()
                }
            }
            return
        } successCompletion: { _ in
            print("")
        } failureCompletion: {
            print("")
        } completion: { data, response, error in
            do {
                let response = try JSONDecoder().decode(EventData.self, from: data)
                
                DispatchQueue.main.async {
                    viewModel.favouriteEvents = response.data
                    viewModel.favouriteEventsLoading = false
                }
                for event in response.data {print(event.location)}
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func eventDetails(viewModel: MainTabViewModel, eventId: Int) {
        
        let request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.postEvent + "\(eventId)/", httpMethod: Constants.API.HttpMethods.get, authTokenNeeded: true, body: nil, isMultipart: false, image: nil)
        
        guard request != nil else { return }
        
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do {
                print(data)
                
                let response = try JSONDecoder().decode(DetailedEventData.self, from: data)
                
                DispatchQueue.main.async {
                    viewModel.detailedEventForExplore = response.data
                    viewModel.showDetailedEventForExplore = false
                }
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func getFilteredEvents(viewModel: MainTabViewModel) {
        //you can create an object of location manager here to get the coordinates of the user
        // for trial purposes use static coordinates
        // Create a URLComponents object with your base URL
        var urlComponents = URLComponents(string: Constants.API.URLs.postEvent)!
        
        // Add query parameters
        let queryItems: [(String, String)] = [
            ("event_category","\((Constants.Labels.eventTypes.firstIndex(of: viewModel.filter.eventCategory ?? Constants.Labels.eventTypes[0]) ?? 0) + 1)"),
            ("start_date"    ,Formatter.shared.formatSingleDate(date: viewModel.filter.startDate!)),
            ("title"         , viewModel.filter.title),
            ("hashtag"       ,viewModel.filter.hashtag),
            ("radius"        ,"\(viewModel.filter.radius)"),
            ("location"      ,viewModel.filter.location)
        ]
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_latitude", value: "30.711214"),
            URLQueryItem(name: "user_longitude", value: "76.690276"),
            // Add more query items as needed
        ]
        
        for index in viewModel.checks.indices {
            if viewModel.checks[index] {
                urlComponents.queryItems?.append(URLQueryItem(name: queryItems[index].0, value: queryItems[index].1))
            }
        }
        
        // Create a URL from the URLComponents
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Constants.API.HttpMethods.get
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        NetworkHelper.shared.performRequest(request: request, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do {
                print(data)
                
                let response = try JSONDecoder().decode(EventData.self, from: data)
                DispatchQueue.main.async {
                    viewModel.events = response.data
                }
                print("number of filtered events are \(response.data.count)")
                
                for event in response.data {
                    print(event.location)
                }
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func updateEvent(viewModel: MainTabViewModel) {
        var fields: [String: Any] = [:]
        
        fields[Constants.Keys.eventCategoryId] = (Constants.Labels.eventTypes.firstIndex(of: viewModel.newEventForEdit.selectedOption ?? Constants.Labels.eventTypes[0]) ?? 0) + 1
        fields[Constants.Keys.title]           = viewModel.newEventForEdit.title
        fields[Constants.Keys.description]     = viewModel.newEventForEdit.description
        fields[Constants.Keys.location]        = "\(viewModel.newEventForEdit.pickedMark?.name ?? viewModel.eventForEdit!.location),  \(viewModel.newEventForEdit.pickedMark?.locality ?? "")"
        fields[Constants.Keys.latitude]        = viewModel.newEventForEdit.pickedLocation?.coordinate.latitude ?? viewModel.eventForEdit!.latitude
        fields[Constants.Keys.longitude]       = viewModel.newEventForEdit.pickedLocation?.coordinate.longitude ?? viewModel.eventForEdit!.longitude
        fields[Constants.Keys.startDate]       = viewModel.newEventForEdit.formattedStartDate
        fields[Constants.Keys.startTime]       = viewModel.newEventForEdit.formattedStartTime
        fields[Constants.Keys.endDate]         = viewModel.newEventForEdit.formattedEndDate
        fields[Constants.Keys.endTime]         = viewModel.newEventForEdit.formattedEndTime
        fields[Constants.Keys.hashtags]        = viewModel.newEventForEdit.hashtags
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.postEvent + "\(viewModel.eventForEdit!.id)/", httpMethod: Constants.API.HttpMethods.put, authTokenNeeded: true, body: fields, isMultipart: true, image: viewModel.newEventForEdit.imagePicker2.image)
        
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do {
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print(response.message)
            }
            catch {
                print("error decoding the response")
            }
            guard let httpResponse = response as? HTTPURLResponse else {return}
            DispatchQueue.main.async {
                if httpResponse.statusCode == 200 {
                    viewModel.showEditSheet.toggle()
                    viewModel.newEventForEdit = NewEvent()
                }
            }
        }
    }
    
    func postNewEvent(viewModel: MainTabViewModel, appState: AppState) {
        
        var fields: [String: Any] = [:]
        
        fields[Constants.Keys.eventCategoryId] = (Constants.Labels.eventTypes.firstIndex(of: viewModel.newEvent.selectedOption ?? Constants.Labels.eventTypes[0]) ?? 0) + 1
        fields[Constants.Keys.title]           = viewModel.newEvent.title
        fields[Constants.Keys.description]     = viewModel.newEvent.description
        fields[Constants.Keys.location]        = "\(viewModel.newEvent.pickedMark?.name ?? ""),  \(viewModel.newEvent.pickedMark?.locality ?? "")"
        fields[Constants.Keys.latitude]        = viewModel.newEvent.pickedLocation?.coordinate.latitude ?? 0.0
        fields[Constants.Keys.longitude]       = viewModel.newEvent.pickedLocation?.coordinate.longitude ?? 0.0
        fields[Constants.Keys.startDate]       = viewModel.newEvent.formattedStartDate
        fields[Constants.Keys.startTime]       = viewModel.newEvent.formattedStartTime
        fields[Constants.Keys.endDate]         = viewModel.newEvent.formattedEndDate
        fields[Constants.Keys.endTime]         = viewModel.newEvent.formattedEndTime
        fields[Constants.Keys.hashtags]        = viewModel.newEvent.hashtags
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.postEvent, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: true, body: fields, isMultipart: true, image: viewModel.newEvent.imagePicker2.image)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!) {
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    viewModel.postingNewEvent = false
                    viewModel.showCreateEventAlert.toggle()
                }
            }
            return
        } successCompletion: { _ in
            print("")
        } failureCompletion: {
            print("")
        } completion: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {return}
            do {
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print(response.message)
            }
            catch {
                print("error decoding the response")
            }
            
            DispatchQueue.main.async {
                viewModel.postingNewEvent = false
                
                if httpResponse.statusCode == 200 {
                    print("event was posted successfully")
                    viewModel.shiftTabToMyEvents()
                    appState.rootViewId = UUID()
                    viewModel.newEvent = NewEvent()
                }
                else {
                    print("some error occured")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
    }
    
    func deleteEvent(eventId: Int) {
        
        let bodyData: [String: Any] = [
            Constants.Keys.eventId : eventId
        ]
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.postEvent + "\(eventId)/", httpMethod: Constants.API.HttpMethods.delete, authTokenNeeded: true, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func markEventAsFavourite(eventId: Int) {
        let bodyData: [String: Any] = [
            Constants.Keys.eventId : eventId
        ]
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.markFavEvent, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: true, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func likeTheEvent(eventId: Int) {
        
        let bodyData: [String: Any] = [
            Constants.Keys.eventId : eventId
        ]
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.likeEvent, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: true, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func joinEvent(eventId: Int) {
        
        let bodyData: [String: Any] = [
            "event_id" : eventId
        ]
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.joinEvent, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: true, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func followUser(userId: Int) {
        let bodyData: [String: Any] = [
            "user_id" : userId
        ]
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.followUser, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: true, body: bodyData, isMultipart: false, image: nil)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            do{
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print("decode successful " + response.message)
                print("code is \(response.status)")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
    }
    
    func createUserProfile(viewModel: LoginViewModel) {
        
        let fields: [String: Any] = [
            Constants.Keys.firstName : viewModel.firstName,
            Constants.Keys.lastName : viewModel.lastName,
            Constants.Keys.dob : viewModel.dob,
            Constants.Keys.phoneNumber : viewModel.phoneNumber,
            Constants.Keys.address : viewModel.address
        ]
        
        var request = NetworkHelper.shared.createURLRequest(urlString: Constants.API.URLs.setProfile, httpMethod: Constants.API.HttpMethods.post, authTokenNeeded: true, body: fields, isMultipart: true, image: viewModel.imagePicker.image)
        guard request != nil else {return}
        NetworkHelper.shared.performRequest(request: request!, dataCompletion: nil, successCompletion: nil, failureCompletion: nil) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {return}
            
            do {
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print(response.message)
            }
            catch {
                print("error decoding the response")
            }
            
            DispatchQueue.main.async {
                viewModel.isLoggedIn = false
                if httpResponse.statusCode == 200 {
                    viewModel.presentMainTabView.toggle()
                }
                else {
                    print("some error occured while signing up")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
    }
}

