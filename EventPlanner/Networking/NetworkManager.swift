//
//  Network.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.

import Foundation
import UIKit


class NetworkManager {
    
    private init () {}
    static let shared = NetworkManager()
    
    var authorizationKey: String = ""
    
    func signUpCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        
        
        guard let url = URL(string: Constants.API.URLs.signUp) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : userCredentials.email,
            Constants.Keys.password : userCredentials.password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
        } catch {
            print("Unable to serialize request body")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let authorizationKey = httpResponse.allHeaderFields[Constants.API.authorizationHeaderField] as? String {
                    self.authorizationKey = authorizationKey
                    UserDefaults.standard.set(self.authorizationKey, forKey: Constants.Labels.authToken)
                    UserDefaults.standard.set(true, forKey: Constants.Labels.userLoggedIn)
                    UserDefaults.standard.set(false, forKey: Constants.Labels.guestLoginKey)
                    print(self.authorizationKey)
                }
            } else {
                print("unable to sign up")
                print("Error: Unexpected status code \(httpResponse.statusCode)")
                viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                viewModel.showAlert = true
            }
            
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
        task.resume()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Call your function here
            self.createUserProfile(viewModel: viewModel)

        }
    }
    
    func logInCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        
        print("login button clicked")
        
        guard let url = URL(string: Constants.API.URLs.logIn) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : userCredentials.email,
            Constants.Keys.password : userCredentials.password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
        } catch {
            print("Unable to serialize request body")
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                print("error occured while logging in")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let authorizationKey = httpResponse.allHeaderFields[Constants.API.authorizationHeaderField] as? String {
                    self.authorizationKey = authorizationKey
                    UserDefaults.standard.set(self.authorizationKey, forKey: Constants.Labels.authToken)
                    print(self.authorizationKey)
                }
            } else {
                print("unable to login")
                print("Error: Unexpected status code \(httpResponse.statusCode)")
            }
            
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
                
                if httpResponse.statusCode == 200 {
                    print(httpResponse.statusCode)
                    viewModel.presentMainTabView.toggle()
                    UserDefaults.standard.set(true, forKey: Constants.Labels.userLoggedIn)
                    UserDefaults.standard.set(false, forKey: Constants.Labels.guestLoginKey)
                }
                else {
                    print("some error occured while logging in")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
        task.resume()
    }
    
    func signOutCall(viewModel: MainTabViewModel) {
        
        UserDefaults.standard.set(false, forKey: Constants.Labels.userLoggedIn)
        
        
        guard let url = URL(string: Constants.API.URLs.logOut) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        request.setValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
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
        task.resume()
    }
    
    func resendOtp(viewModel: ForgotPasswordViewModel) {
        guard let url = URL(string: Constants.API.URLs.forgotPassword) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : viewModel.email
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
        } catch {
            print("Unable to serialize request body")
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode != 200 {
                viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                viewModel.showAlert = true
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
        }
        task.resume()
    }
    
    func forgotPassword(viewModel: ForgotPasswordViewModel) {
        guard let url = URL(string: Constants.API.URLs.forgotPassword) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : viewModel.email
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
        } catch {
            print("Unable to serialize request body")
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
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
        task.resume()
    }
    
    func verifyOtp(viewModel: ForgotPasswordViewModel) {
        guard let url = URL(string: Constants.API.URLs.verifyOtp) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        
        let bodyData: [String: Any] = [
            Constants.Keys.email : viewModel.email,
            Constants.Keys.otp : viewModel.otp
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
        } catch {
            print("Unable to serialize request body")
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
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
        task.resume()
    }
    
    func resetPassword(viewModel: ForgotPasswordViewModel) {
        
        viewModel.resetPasswordSuccessful = false
        guard let url = URL(string: Constants.API.URLs.resetPassword) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.put
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        
        let bodyData: [String: Any] = [
            Constants.Keys.email: viewModel.email,
            Constants.Keys.password : viewModel.newPassword
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
        } catch {
            print("Unable to serialize request body")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("password reset was successful")
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
                    UserDefaults.standard.set(true, forKey: Constants.Labels.guestLoginKey)
                    viewModel.resetPasswordSuccessful.toggle()
                }
                else {
                    print("some error occured while resetting the password")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
        task.resume()
    }
    
    private func createUserProfile(viewModel: LoginViewModel) {
        guard let url = URL(string: Constants.API.URLs.setProfile) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        
        let boundary = "Boundary-testpqr"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        request.addValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        
        let fields: [String: Any] = [
            Constants.Keys.firstName : viewModel.firstName,
            Constants.Keys.lastName : viewModel.lastName,
            Constants.Keys.dob : viewModel.dob,
            Constants.Keys.phoneNumber : viewModel.phoneNumber,
            Constants.Keys.address : viewModel.address
        ]
        
        let httpBody = createHttpBodyForUpdatingProfile(from: fields, image: viewModel.imagePicker.image)
        request.httpBody = httpBody
        
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("user profile is updated successfully")
            }
            else {
                print("error in creating the profile")
            }
            
            
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
        task.resume()
    }
    
    func getUserProfileDetails(viewModel: MainTabViewModel) {
        guard let url = URL(string: Constants.API.URLs.getProfile) else {
            print("unable to create url")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.get
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        request.addValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                print("error occured while logging in")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("getting user profile successful")
            }
            else {
                print("some error in gettting the user profile")
            }
            
            do {
                print(data)
                let response = try JSONDecoder().decode(UserData.self, from: data)
                
                print(response.message)
                print(response.data.dob)
                print(response.data.phone_number)
                print(response.data.address)
                print(response.data.profile_image ?? "")
                
                viewModel.phoneNumber = String(response.data.phone_number)
                viewModel.address = response.data.address
                viewModel.firstName = response.data.first_name
                viewModel.lastName = response.data.last_name
                viewModel.dob = response.data.dob
                viewModel.imageUrl = response.data.profile_image ?? ""
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func updateUserProfileDetails(viewModel: MainTabViewModel) {
        guard let url = URL(string: Constants.API.URLs.updateProfile) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.put
        
        let boundary = "Boundary-testpqr"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        request.addValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        let fields: [String: Any] = [
            Constants.Keys.firstName : viewModel.firstName,
            Constants.Keys.lastName : viewModel.lastName,
            Constants.Keys.dob : viewModel.dob,
            Constants.Keys.phoneNumber : viewModel.phoneNumber,
            Constants.Keys.address : viewModel.address
        ]
        
        let httpBody = createHttpBodyForUpdatingProfile(from: fields, image: viewModel.imagePicker.image)
        request.httpBody = httpBody
        
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("user profile is updated successfully")
            }
            else {
                print("error in updating the profile")
            }
            
            
            do {
                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
                print(response.message)
            }
            catch {
                print("error decoding the response")
            }
            
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
        task.resume()
    }
    
    func getEvents() {
        guard let url = URL(string: Constants.API.URLs.getEvents) else {
            print("unable to create url")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.get
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
//        request.addValue("Token 081f05876aebc70b249e87d8f0cc58358e9f1d39", forHTTPHeaderField: Constants.API.authorizationHeaderField)
//        request.addValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                print("error occured while logging in")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("getting user profile successful")
            }
            else {
                print("some error in gettting the user profile")
            }
            
            do {
                print(data)
                let response = try JSONDecoder().decode(EventData.self, from: data)
                
                for event in response.data {
                    print(event.location)
                }
                
//                print(response.message)
//                print(response.data.dob)
//                print(response.data.phone_number)
//                print(response.data.address)
//                print(response.data.profile_image ?? "")
            }
            catch {
                print("unable to decode the response")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func postNewEvent(viewModel: AddEventViewModel, appState: AppState) {
        guard let url = URL(string: Constants.API.URLs.postEvent) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        
        let boundary = "Boundary-testpqr"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        request.addValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        var fields: [String: Any] = [:]
        
        fields[Constants.Keys.eventCategoryId] = Constants.Labels.eventTypes.firstIndex(of: viewModel.selectedOption) ?? 0
        fields[Constants.Keys.title]           = viewModel.title
        fields[Constants.Keys.description]     = viewModel.description
        fields[Constants.Keys.location]        = "\(viewModel.pickedMark?.name ?? ""),  \(viewModel.pickedMark?.locality ?? ""), \(viewModel.pickedMark?.subLocality ?? "")"
        fields[Constants.Keys.latitude]        = viewModel.pickedLocation?.coordinate.latitude ?? 0.0
        fields[Constants.Keys.longitude]       = viewModel.pickedLocation?.coordinate.longitude ?? 0.0
        fields[Constants.Keys.startDate]       = viewModel.formattedStartDate
        fields[Constants.Keys.startTime]       = viewModel.formattedStartTime
        fields[Constants.Keys.endDate]         = viewModel.formattedEndDate
        fields[Constants.Keys.endTime]         = viewModel.formattedEndTime
        fields[Constants.Keys.hashtags]        = viewModel.hashtags
        
        let httpBody = createHttpBodyForPostingEvent(from: fields, image: viewModel.imagePicker.image)
        request.httpBody = httpBody
        
        
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("New event is posted successfully")
            }
            else {
                print("error in posting the event")
            }
            
            
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
                    //pop the navigation views
                    appState.rootViewId = UUID()
                }
                else {
                    print("some error occured")
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
            }
        }
        task.resume()
    }
    
    private func createHttpBodyForPostingEvent(from fields: [String: Any], image: UIImage?) -> Data? {
        return createMultipartBody(from: fields, image: image)
    }
    
    private func createHttpBodyForUpdatingProfile(from fields: [String: Any], image: UIImage?) -> Data? {
        return createMultipartBody(from: fields, image: image)
    }
    
    private func createMultipartBody(from fields: [String: Any], image: UIImage?) -> Data? {
        let boundary = "Boundary-testpqr"
        var body = Data()
        
        for (key, value) in fields {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        if let image = image {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(image.jpegData(compressionQuality: 0.3)!)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

