//
//  ProfileView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        
        if viewModel.guestLogin {
            LoginSignupView()
        }
        else if viewModel.userLogin {
            ZStack {
                VStack {
                    Text("profile view in user login")
                    Button("sign out") {
                        viewModel.signOutCall()
                    }
                    Button("edit profile") {
                        viewModel.showEditProfileView.toggle()
                    }
                    .fullScreenCover(isPresented: $viewModel.showEditProfileView) {
                        EditUserProfileView(viewModel: viewModel)
                    }
                }
                if viewModel.isLoggedOut {
                    LoadingView()
                }
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
