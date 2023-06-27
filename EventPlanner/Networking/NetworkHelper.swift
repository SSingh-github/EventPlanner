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
