//
//  UserProfile.swift
//  EventPlanner
//
//  Created by Chicmic on 02/06/23.
//

import Foundation

struct UserProfile {
    let firstName: String
    let lastName: String
    let phoneNumber: String 
    let dob: String
    let address: String
}
// this is the format for get profile request
//{
//    "status":200,
//    "message":"successfully fetched data",
//    "data":{
//        "dob":"2000-03-24",
//        "phone_number":12344555666,
//        "address":"mohali sector 58",
//        "first_name":"Sukhpreet",
//        "last_name":"Singh",
//        "profile_image":null
//    }
//}

//{"status":200,"message":"profile created successfully"} for creating the profile post
//{"status":200,"message":"profile updated successfully"} for updating with put
