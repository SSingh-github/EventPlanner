//
//  EventPlannerApp.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

@main
struct EventPlannerApp: App {
    @StateObject var appState: AppState = AppState()
    @State var isActive: Bool = false
   
    var body: some Scene {
        WindowGroup {
            Group {
                if isActive {
                    if  UserDefaults.standard.bool(forKey: Constants.Labels.userLoggedIn) && appState.loggedIn {
                        MainTabView()
                            .environmentObject(appState)
                    }
                    else  {
                        LoginSignupView()
                            .environmentObject(appState)
                    }
                }
                else {
                    SplashScreenView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                       isActive = true
                    }
                }
            }
        }
    }
}
