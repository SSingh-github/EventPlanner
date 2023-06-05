//
//  Network.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
// handle all the error cases in network calls

import Foundation


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

        
        let body =  """
        {
        "email": "\(userCredentials.email)",
        "password":"\(userCredentials.password)"
        }
        """
        request.httpBody = body.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
               // print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let authorizationKey = httpResponse.allHeaderFields[Constants.API.authorizationHeaderField] as? String {
                    self.authorizationKey = authorizationKey
                    UserDefaults.standard.set(authorizationKey, forKey: Constants.Labels.authToken)
                    print(self.authorizationKey)
                }
            } else {
                print("unable to sign up")
                print("Error: Unexpected status code \(httpResponse.statusCode)")
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
            
            DispatchQueue.main.async {
                viewModel.isLoggedIn = false
               // Present the full-screen cover sheet view here
                if httpResponse.statusCode == 200 {
                    viewModel.presentMainTabView.toggle()
                    UserDefaults.standard.set(true, forKey: Constants.Labels.userLoggedIn)
                    UserDefaults.standard.set(false, forKey: Constants.Labels.guestLoginKey)
                }
                else {
                    print("some error occured while signing up")
                    //show alert here
                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
                    viewModel.showAlert = true
                }
           }
            //print("successs? \(viewModel.signInIsSuccessful)")
        }
        task.resume()
    }
    
    func logInCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        
        print("login button clicked")
        
         guard let url = URL(string: Constants.API.URLs.logIn) else {
             return
         }

         var request = URLRequest(url: url)

         request.httpMethod = Constants.API.HttpMethods.post
         request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)


         let body =  """
         {
         "email": "\(userCredentials.email)",
         "password":"\(userCredentials.password)"
         }
         """
         //sukhpreetsingh@gmail.com, 1111111
         request.httpBody = body.data(using: .utf8)

         //make the request

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
                     UserDefaults.standard.set(authorizationKey, forKey: Constants.Labels.authToken)
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
        request.setValue("\(self.authorizationKey)", forHTTPHeaderField: Constants.API.authorizationHeaderField)


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


        let body =  """
        {
        "email": "\(viewModel.email)"
        }
        """
    
        request.httpBody = body.data(using: .utf8)


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


        let body =  """
        {
        "email": "\(viewModel.email)"
        }
        """
    
        request.httpBody = body.data(using: .utf8)


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


        let body =  """
        {
        "email": "\(viewModel.email)",
        "otp":"\(viewModel.otp)"
        }
        """
        request.httpBody = body.data(using: .utf8)


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


        let body =  """
        {
        "email": "\(viewModel.email)",
        "password": "\(viewModel.newPassword)"
        }
        """
        
        request.httpBody = body.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                viewModel.resetPasswordSuccessful = true
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
                    viewModel.resetPasswordSuccessful = true
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
    
    /*
     whenever the user signs in or signs up, save the token in the user defaults
     use the same token to upload, update and get the user details
     */
    

    
    func getUserProfileDetails() {
        
    }
    
    
    
    func updateUserProfileDetails(viewModel: MainTabViewModel) {
        guard let url = URL(string: Constants.API.URLs.updateProfile) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.put
        
        let boundary = "Boundary-testpqr"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("\(self.authorizationKey)", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        print("first name is \(viewModel.firstName)")
        print("last name is \(viewModel.lastName)")
        
        let httpBody = createHttpBody(viewModel: viewModel)
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
    
    func postNewEvent(viewModel: AddEventViewModel) {
        guard let url = URL(string: Constants.API.URLs.postEvent) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = Constants.API.HttpMethods.post
        
        let boundary = "Boundary-testpqr"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("\(self.authorizationKey)", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        
        let httpBody = createEventHttpBody(viewModel: viewModel)
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
            
//            DispatchQueue.main.async {
//                viewModel.editProfileLoading = false
//
//                if httpResponse.statusCode == 200 {
//                    print("profile was updated successfully")
//                    viewModel.showEditProfileView.toggle()
//                }
//                else {
//                    print("some error occured")
//                    viewModel.alertMessage = Constants.Labels.Alerts.alertMessage
//                    viewModel.showAlert = true
//                }
//           }
        }
        task.resume()
    }
    
    func createEventHttpBody(viewModel: AddEventViewModel) -> Data? {
        let boundary = "Boundary-testpqr"
        var body = Data()


        // Add first name field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"event_category_id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(Constants.Labels.eventTypes.firstIndex(of: viewModel.selectedOption) ?? 0)\r\n".data(using: .utf8)!)

        // Add last name field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"title\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.title)\r\n".data(using: .utf8)!)

        // Add dob field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.description)\r\n".data(using: .utf8)!)

        // Add phone number field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"location\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.pickedMark?.name ?? ""),  \(viewModel.pickedMark?.locality ?? ""), \(viewModel.pickedMark?.subLocality ?? "")\r\n".data(using: .utf8)!)

        // Add address field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"latitude\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.pickedLocation?.coordinate.latitude ?? 0.0)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"longitude\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.pickedLocation?.coordinate.longitude ?? 0.0)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"start_date\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.formattedStartDate)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"start_time\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.formattedStartTime)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"end_date\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.formattedEndDate)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"end_time\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.formattedEndTime)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"hashtags\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.hashtags)\r\n".data(using: .utf8)!)

        // Add image field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(viewModel.imagePicker.image?.jpegData(compressionQuality: 0.3) ?? Data())
        body.append("\r\n".data(using: .utf8)!)

        // Add closing boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return body
    }
    
    func createHttpBody(viewModel: MainTabViewModel) -> Data? {
        let boundary = "Boundary-testpqr"
        var body = Data()


        // Add first name field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"first_name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.firstName)\r\n".data(using: .utf8)!)

        // Add last name field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"last_name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.lastName)\r\n".data(using: .utf8)!)

        // Add dob field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"dob\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.dob)\r\n".data(using: .utf8)!)

        // Add phone number field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"phone_number\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.phoneNumber)\r\n".data(using: .utf8)!)

        // Add address field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"address\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.address)\r\n".data(using: .utf8)!)

        // Add image field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(viewModel.imagePicker.image?.jpegData(compressionQuality: 0.3) ?? Data())
        body.append("\r\n".data(using: .utf8)!)

        // Add closing boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return body
    }
}

