//
//  NewEvent.swift
//  EventPlanner
//
//  Created by Chicmic on 21/06/23.
//

import Foundation
import CoreLocation

struct NewEvent {
    var selectedOption: String? = ""
    var title = ""
    var description = ""
    var hashtags: [String] = []
    var startDate = Date()
    var endDate = Date()
    var formattedStartDate = ""
    var formattedEndDate = ""
    var formattedStartTime = ""
    var formattedEndTime = ""
    var pickedLocation: CLLocation?
    var pickedMark: CLPlacemark?
    var imagePicker2 = ImagePicker()
}
