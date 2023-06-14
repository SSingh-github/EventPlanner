//
//  DetailedEvent.swift
//  EventPlanner
//
//  Created by Chicmic on 14/06/23.
//

import Foundation

struct DetailedEventData: Codable {
    let data: DetailedEvent
}

struct DetailedEvent: Codable {
    let id : Int
    let event_category_id: Int
    let is_approved: Bool
    let title: String
    let description: String
    let location: String
    let longitude: Double
    let latitude: Double
    let start_date: String
    let start_time: String
    let end_date: String
    let end_time: String
    let image: String?
    let event_status: Int
    let hashtags: [String]
    let is_liked: Bool
    let is_favourite: Bool
    let event_attendees_count: Int
    let like_count: Int
    
    let user_name: String
    let user_image: String?
    let user_id: Int
    let follower_count: Int
    let can_join_event: Bool
    let is_joined: Bool
}


