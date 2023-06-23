//
//  Filter.swift
//  EventPlanner
//
//  Created by Chicmic on 12/06/23.
//

import Foundation

struct Filter {
    var eventCategory: String?
    var startDate: Date
    var hashtag: String
    var title: String
    var radius: Double
    var location: String
    
    init () {
        eventCategory = nil
        startDate = Date()
        hashtag = ""
        title = ""
        radius = 5.0
        location = ""
    }
}
