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
}

