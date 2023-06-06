//
//  AddEventViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//

import Foundation
import CoreLocation
// fields to send are :
/*
 selectedOption, title, description, hastags, formattedStartDate, formattedEndDate, formattedStartTime, formattedEndTime
 pickedLocation.latitude, pickedLocation.longitude, pickedMark.name + pickedMark.locality, imagePicker.image
 */

class AddEventViewModel: ObservableObject {
    @Published var selectedOption = "" // when sending the data send the index array.firstIndex(of: selectedOption)
    @Published var title = ""
    @Published var description = ""
    @Published var hashtags: [String] = []
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var formattedStartDate = ""
    @Published var formattedEndDate = ""
    @Published var formattedStartTime = ""
    @Published var formattedEndTime = ""
    @Published var pickedLocation: CLLocation?
    @Published var pickedMark: CLPlacemark?
    // var location = pickedMark.name + " " + pickedMark.locality
    @Published var imagePicker = ImagePicker()
    @Published var postingNewEvent = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func printData() {
        print("selected option is \(selectedOption)")
        print("title is \(title)")
        print("description is \(description)")
        print("hashtags \(hashtags)")
        print("dates are \(formattedStartDate) and \(formattedEndDate)")
        print("times are \(formattedStartTime) and \(formattedEndTime)")
        print("location is \(pickedMark?.name ?? "") + \(pickedMark?.locality ?? "") + \(pickedMark?.subLocality ?? "")")
        print("coordinates are \(pickedLocation?.coordinate.latitude ?? 0.0), \(pickedLocation?.coordinate.longitude ?? 0.0)")
    }
    
    func postNewEvent() {
        self.postingNewEvent = true
        NetworkManager.shared.postNewEvent(viewModel: self)
    }

}
