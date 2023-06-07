//
//  ViewIdClass.swift
//  EventPlanner
//
//  Created by Chicmic on 07/06/23.
//

import Foundation

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
}
