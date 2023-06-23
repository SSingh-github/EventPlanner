//
//  NewEventView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct NewEventView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
   
    var body: some View {
        
        if viewModel.guestLogin {
            LoginSignupView()
        }
        else if viewModel.userLogin {
            AddNewEventView(viewModel: viewModel)
        }
    }
}


