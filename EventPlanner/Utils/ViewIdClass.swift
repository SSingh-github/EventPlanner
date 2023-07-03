//
//  ViewIdClass.swift
//  EventPlanner
//
//  Created by Chicmic on 07/06/23.
//

import Foundation

class AppState : ObservableObject {
    @Published var rootViewId = UUID()
    @Published var loggedIn :Bool = true
}
