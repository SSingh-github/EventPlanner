//
//  UserProfile.swift
//  EventPlanner
//
//  Created by Chicmic on 02/06/23.
//

import Foundation

struct UserData: Codable {
    let status: Int
    let message: String
    let data: UserDataDetails
}

struct UserDataDetails: Codable {
    var dob: String
    var phone_number: String
    var address: String
    var first_name: String
    var last_name: String
    var profile_image: String?
    
    init () {
        dob = ""
        phone_number = ""
        address = ""
        first_name = ""
        last_name = ""
        profile_image = nil
    }
}
