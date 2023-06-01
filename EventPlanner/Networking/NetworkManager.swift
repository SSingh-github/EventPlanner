//
//  Network.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import Foundation

class NetworkManager {
    
    private init () {}
    static let shared = NetworkManager()
    //var viewModel: LoginViewModel?
    
    var authorizationKey: String = ""
    
    func signUpCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        print("sign up call")
    }
    
    func logInCall(for userCredentials: UserCredentials, viewModel: LoginViewModel) {
        
         guard let url = URL(string: Constants.API.URLs.signIn) else {
             return
         }

         var request = URLRequest(url: url)

         //method, body, headers
         request.httpMethod = Constants.API.HttpMethods.post
         request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)


         let body =  """
         {
             "user": {
                 "email": "\(userCredentials.email)",
                 "password":"\(userCredentials.password)"
             }
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
                 viewModel.isLoggedIn = false
                // Present the full-screen cover sheet view here
                 viewModel.presentMainTabView.toggle()
            }
             //print("successs? \(viewModel.signInIsSuccessful)")
         }
         task.resume()
     }

    
    func signOutCall() {
        
    }
}

