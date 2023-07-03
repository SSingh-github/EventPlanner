//
//  NetworkHelper.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import Foundation
import UIKit

class NetworkHelper {
    private init () {}
    
    static let shared = NetworkHelper()
    
    //MARK: METHODS
    
    /// Creates the URLRequest object from the given details and returns the request object
    ///
    ///  - Parameters:
    ///     - urlsString:  the url in string format.
    ///     - httpMethod: the http request method.
    ///     - authTokenNeeded: this boolean value indicates whether the request needs the authentication token or not.
    ///     - body: this contains the optional body for the http request
    ///     - isMultipart: this boolean value indicates whether the request is a multipart request or not.
    ///     - image: this optional value contains the image if the request is a multipart request.
    ///
    /// - Returns: The optional URLRequest for performing the request.
    ///
    func createURLRequest(urlString: String, httpMethod: String, authTokenNeeded: Bool, body: [String: Any]?, isMultipart: Bool, image: UIImage?) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        if isMultipart {
            let boundary = "Boundary-testpqr"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        }
        else {
            request.setValue(Constants.API.requestValueType, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        }
        
        if authTokenNeeded {
            request.setValue("\(UserDefaults.standard.string(forKey: Constants.Labels.authToken) ?? "")", forHTTPHeaderField: Constants.API.authorizationHeaderField)
        }
        
        if isMultipart {
            let httpBody = createMultipartBody(from: body!, image: image)
            request.httpBody = httpBody
        }
        else {
            if let bodyData = body {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
                } catch {
                    print("Unable to serialize request body")
                    return nil
                }
            }
        }
        
        return request
    }
    
    /// Performs the http request for the given request object
    ///
    ///  - Parameters:
    ///     - request: the URLRequest object needed to perform the http request.
    ///     - dataCompletion: optional closure to be executed if the data is successfully fetched.
    ///     - successCompletion: optional closure that takes the HTTPURLResponse as its parameter and get executed if the status code is 200.
    ///     - failureCompletion: optional closure to be executed if the status code of the response if not as intended.
    ///     - completion: escaping closure that takes Data, URLResponse and Error object as its paramters and get executed after the URLSession is started.
    ///
    ///  - Returns: Returns nothing.
    ///
    func performRequest(request: URLRequest, dataCompletion: (() -> Void)?, successCompletion: ((HTTPURLResponse) -> Void)?, failureCompletion: (() -> Void)?, completion: @escaping (Data, URLResponse?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                if let dataCompletion = dataCompletion {
                    dataCompletion()
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let successCompletion = successCompletion {
                    successCompletion(httpResponse)
                }
            }
            else {
                if let failureCompletion = failureCompletion {
                    failureCompletion()
                }
            }
            completion(data, response, error)
        }
        task.resume()
    }
    
    /// A private method to create the body for the multipart request
    ///
    ///  - Parameters:
    ///     - fields: the dictionary containing the the fields for performing the request.
    ///     - image: contains the optional image for creating the body for the multipart request.
    ///
    ///  - Returns: the optional data object for performing the multipart request.
    ///
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

