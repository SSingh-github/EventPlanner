//
//  ContentView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var appState: AppState = AppState()
    
    var body: some View {
        if UserDefaults.standard.bool(forKey: Constants.Labels.guestLoginKey) || UserDefaults.standard.bool(forKey: Constants.Labels.userLoggedIn) {
            MainTabView()
                .environmentObject(appState)
        }
        else {
            LoginSignupView()
                .environmentObject(appState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
