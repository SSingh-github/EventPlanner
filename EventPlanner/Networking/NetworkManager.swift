//
//  Network.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.

import Foundation

class NetworkManager {
    
    private init () {}
    static let shared = NetworkManager()
    //var viewModel: LoginViewModel?
    
    var authorizationKey: String = ""
    
    func signUpCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        guard let url = URL(string: Constants.API.URLs.signUp) else {
            return
        }

        var request = URLRequest(url: url)

        //method, body, headers
        request.httpMethod = Constants.API.HttpMethods.post
        request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
//        request.setValue("\(viewModel.authorizationKey)", forHTTPHeaderField: Constants.authorizationHeaderField)

        
        let body =  """
        {
        "email": "\(userCredentials.email)",
        "password":"\(userCredentials.password)"
        }
        """
        request.httpBody = body.data(using: .utf8)

        //make the request

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
                print("Error: Unexpected status code \(httpResponse.statusCode)")
            }
            
            DispatchQueue.main.async {
                viewModel.isLoggedIn = false
               // Present the full-screen cover sheet view here
                if httpResponse.statusCode == 200 {
                    viewModel.presentMainTabView.toggle()
                }
                else {
                    print("some error occured while signing up")
                }
           }
            //print("successs? \(viewModel.signInIsSuccessful)")
        }
        task.resume()
    }
    
    func logInCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        
         guard let url = URL(string: Constants.API.URLs.logIn) else {
             return
         }

         var request = URLRequest(url: url)

         //method, body, headers
         request.httpMethod = Constants.API.HttpMethods.post
         request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
//        request.setValue("\(viewModel.authorizationKey)", forHTTPHeaderField: Constants.authorizationHeaderField)


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
                 print("Error: Unexpected status code \(httpResponse.statusCode)")
             }
             
             DispatchQueue.main.async {
                 viewModel.isLoggedIn = false
                // Present the full-screen cover sheet view here
                 if httpResponse.statusCode == 200 {
                     print(httpResponse.statusCode)
                     viewModel.presentMainTabView.toggle()
                 }
            }
             //print("successs? \(viewModel.signInIsSuccessful)")
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
            
            DispatchQueue.main.async {
                viewModel.isLoggedOut = false
               // Present the full-screen cover sheet view here
                if httpResponse.statusCode == 200 {
                    viewModel.showWelcomeViewModel.toggle()
                }
                else {
                    print("some error occured while logout")
                }
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
        //sukhpreetsingh@gmail.com, 1111111
        request.httpBody = body.data(using: .utf8)

        //make the request

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
               // print("Invalid response")
                return
            }

            DispatchQueue.main.async {
                viewModel.forgotPasswordLoading = false
               // Present the full-screen cover sheet view here
                if httpResponse.statusCode == 200 {
                    viewModel.presentOtpView.toggle()
                }
                else {
                    print(httpResponse.statusCode)
                    print("some error occured while forgot password request")
                }
           }
            //print("successs? \(viewModel.signInIsSuccessful)")
        }
        task.resume()
    }
//
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
        //sukhpreetsingh@gmail.com, 1111111
        request.httpBody = body.data(using: .utf8)

        //make the request

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
               // print("Invalid response")
                return
            }

            DispatchQueue.main.async {
                viewModel.verifyOtpLoading = false
               // Present the full-screen cover sheet view here
                if httpResponse.statusCode == 200 {
                    viewModel.presentResetPasswordView.toggle()
                }
           }
            //print("successs? \(viewModel.signInIsSuccessful)")
        }
        task.resume()
    }

    func resetPassword(viewModel: ForgotPasswordViewModel) {
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
        //sukhpreetsingh@gmail.com, 1111111
        request.httpBody = body.data(using: .utf8)

        //make the request

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
               // print("Invalid response")
                return
            }

            DispatchQueue.main.async {
                viewModel.resetPasswordLoading = false
               // Present the full-screen cover sheet view here
                if httpResponse.statusCode == 200 {
                    //present new view after new password is set
                    //change the user default of loggedin to true
                    viewModel.showLoginView.toggle()
                }
                else {
                    print("some error occured while resetting the password")
                }
           }
            //print("successs? \(viewModel.signInIsSuccessful)")
        }
        task.resume()
    }
}

