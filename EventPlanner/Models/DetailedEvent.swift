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
    var id : Int
    var event_category_id: Int
    var is_approved: Bool
    var title: String
    var description: String
    var location: String
    var longitude: Double
    var latitude: Double
    var start_date: String
    var start_time: String
    var end_date: String
    var end_time: String
    var image: String?
    var event_status: Int
    var hashtags: [String]
    var is_liked: Bool
    var is_favourite: Bool
    var event_attendees_count: Int
    var like_count: Int
    var user_name: String
    var user_image: String?
    var user_id: Int
    var follower_count: Int
    var can_join_event: Bool
    var is_joined: Bool
    var is_followed: Bool
}


