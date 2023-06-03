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
    
//    func uploadUserProfileDetails() {
//        //set the user profile
//
//        guard let url = URL(string: Constants.API.URLs.setProfile) else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//
//        //method, body, headers
//        request.httpMethod = Constants.API.HttpMethods.post
//        //request.setValue(Constants.requestValueType, forHTTPHeaderField: Constants.contentTypeHeaderField)
//
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        let httpBody = createHttpBody(viewModel: viewModel)
//        request.httpBody = httpBody
//
//
//        let task = URLSession.shared.dataTask(with: request) {data, response, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(SignoutResponse.self, from: data)
//                print(response)
//            }
//            catch {
//                //print("error hai \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
    
    func getUserProfileDetails() {
        
    }
    
    
    
    func updateUserProfileDetails(viewModel: MainTabViewModel) {
        guard let url = URL(string: Constants.API.URLs.updateProfile) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        //method, body, headers
        request.httpMethod = Constants.API.HttpMethods.put
        //request.setValue(Constants.requestValueType, forHTTPHeaderField: Constants.contentTypeHeaderField)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.addValue("\(self.authorizationKey)", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        
        print("first name is \(viewModel.firstName)")
        print("last name is \(viewModel.lastName)")
        
        let httpBody = createHttpBody(viewModel: viewModel)
        
        let body =  """
        {
        "dob":"\(viewModel.dob)",
        "phone_number":"\(viewModel.phoneNumber)",
        "address":"\(viewModel.address)",
        "first_name":"\(viewModel.firstName)",
        "last_name":"\(viewModel.lastName)",
        "profile_image":"\(viewModel.imagePicker.image?.jpegData(compressionQuality: 0.9) ?? Data())"
        }
        """
        
        //{
        //        "dob":"2000-03-24",
        //        "phone_number":12344555666,
        //        "address":"mohali sector 58",
        //        "first_name":"Sukhpreet",
        //        "last_name":"Singh",
        //        "profile_image":null
        //    }
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
    
    
//    func createHttpBody() -> Data? {
//        let boundary = "Boundary-\(UUID().uuidString)"
//        var body = Data()
//
//        // Add first name field
//        body.append("--\(boundary)\r\n".data(using: .utf8)!)
//        body.append("Content-Disposition: form-data; name=\"first_name\"\r\n\r\n".data(using: .utf8)!)
//        body.append("\(viewm)\r\n".data(using: .utf8)!)
//
//        // Add last name field
//        body.append("--\(boundary)\r\n".data(using: .utf8)!)
//        body.append("Content-Disposition: form-data; name=\"last_name\"\r\n\r\n".data(using: .utf8)!)
//        body.append("\(lastName)\r\n".data(using: .utf8)!)
//
//        // Add age field
//        body.append("--\(boundary)\r\n".data(using: .utf8)!)
//        body.append("Content-Disposition: form-data; name=\"age\"\r\n\r\n".data(using: .utf8)!)
//        body.append("\(age)\r\n".data(using: .utf8)!)
//
//        // Add gender field
//        body.append("--\(boundary)\r\n".data(using: .utf8)!)
//        body.append("Content-Disposition: form-data; name=\"gender\"\r\n\r\n".data(using: .utf8)!)
//        body.append("\(selectedGender.rawValue)\r\n".data(using: .utf8)!)
//
//        // Add image field
//        body.append("--\(boundary)\r\n".data(using: .utf8)!)
//        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
//        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//        body.append(selectedImage?.jpegData(compressionQuality: 0.9) ?? Data())
//        body.append("\r\n".data(using: .utf8)!)
//
//        // Add closing boundary
//        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//
//        return body
//    }
//
    
//    func editCall(viewModel: FormViewModel) {
//
//       // viewModel.editIsSuccessful = false
//
//
//        guard let url = URL(string: Constants.editUrl) else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//
//        //method, body, headers
//        request.httpMethod = Constants.httpPut
//        //request.setValue(Constants.requestValueType, forHTTPHeaderField: Constants.contentTypeHeaderField)
//
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        let httpBody = createHttpBody(viewModel: viewModel)
//        request.httpBody = httpBody
//
//
//        let task = URLSession.shared.dataTask(with: request) {data, response, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            viewModel.editIsSuccessful = true
//
//            do {
//                let response = try JSONDecoder().decode(UserDetails.self, from: data)
//                print(response)
//            }
//            catch {
//                //print("error hai \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
    
    
    func createHttpBody(viewModel: MainTabViewModel) -> Data? {
        let boundary = "Boundary-\(UUID().uuidString)"
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

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"phone_number\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.phoneNumber)\r\n".data(using: .utf8)!)

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"address\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(viewModel.address)\r\n".data(using: .utf8)!)

        // Add image field
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"profile_image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(viewModel.imagePicker.image?.jpegData(compressionQuality: 0.9) ?? Data())
        body.append("\r\n".data(using: .utf8)!)

        // Add closing boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return body
    }
    

}

