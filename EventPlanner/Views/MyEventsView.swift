//
//  MyEventsView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct MyEventsView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {

        if viewModel.guestLogin {
            LoginSignupView()
        }
        else if viewModel.userLogin {
            Text("my event view in user login")
        }
    }
}

//struct MyEventsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyEventsView()
//    }
//}
