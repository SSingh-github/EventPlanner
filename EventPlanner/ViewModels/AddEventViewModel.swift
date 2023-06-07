//
//  AddEventViewModel.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//

import Foundation
import CoreLocation


class AddEventViewModel: ObservableObject {
    @Published var selectedOption = ""
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
    @Published var imagePicker = ImagePicker()
    @Published var postingNewEvent = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func refreshViewModel() {
        self.title = ""
        self.description = ""
        self.description = ""
        self.hashtags = []
        self.startDate = Date()
        self.endDate = Date()
        self.imagePicker = ImagePicker()
    }
    
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
    
    func postNewEvent(viewModel: MainTabViewModel, appState: AppState) {
        self.postingNewEvent = true
        NetworkManager.shared.postNewEvent(viewModel: self, appState: appState)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            viewModel.shiftTabToMyEvents()
        }
    }

}
