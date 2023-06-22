//
//  NewEvent.swift
//  EventPlanner
//
//  Created by Chicmic on 21/06/23.
//

import Foundation
import CoreLocation

struct NewEvent {
    var selectedOption: String?
    var title: String
    var description: String
    var hashtags: [String]
    var startDate: Date
    var endDate:Date
    var formattedStartDate:String
    var formattedEndDate:String
    var formattedStartTime:String
    var formattedEndTime:String
    var pickedLocation: CLLocation?
    var pickedMark: CLPlacemark?
    var imagePicker2: ImagePicker
    
    init() {
        selectedOption = ""
        title = ""
        description = ""
        hashtags = []
        startDate = Date()
        endDate = Date()
        formattedEndDate = ""
        formattedEndTime = ""
        formattedStartDate = ""
        formattedStartTime = ""
        pickedLocation = nil
        pickedMark = nil
        imagePicker2 = ImagePicker()
    }
}
