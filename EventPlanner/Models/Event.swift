//
//  Evnet.swift
//  EventPlanner
//
//  Created by Chicmic on 07/06/23.
//

import Foundation


struct EventData: Codable {
    let data: [Event]
}

struct Event: Codable {
    let title: String
    let description: String
    let location: String
    let longitude: String
    let latitude: String
}
