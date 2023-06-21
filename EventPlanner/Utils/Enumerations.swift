//
//  Enumerations.swift
//  EventPlanner
//
//  Created by Chicmic on 07/06/23.
//

import Foundation

enum Tab {
    case explore
    case search
    case createEvent
    case myEvents
    case profile
}

enum EventType {
    case all
    case favourite
    case joined
    case created
}

enum ApiType {
    case signIn
    case signUp
    case logout
    case forgotPassword
    case verityOtp
    case resetPassword
    case createUserProfile
    case listUserProfile
    case updateUserProfile
    case createEvent
    case updateEvent
    case deleteEvent
    case getEvent
    case listAllEvents
    case listUserEvents
    case markFavourite
    case joinEvent
    case followUser
    case likeEvent
    case listFavouriteEvents
    case filterEvents
}

enum HttpMethod {
    case post
    case get
    case delete
    case put
}

enum EventActionType {
    case createEvent
    case updateEvent
}
