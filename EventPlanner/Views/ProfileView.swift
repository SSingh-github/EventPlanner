//
//  ProfileView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        
        if !viewModel.guestLogin {
            LoginSignupView()
        }
        else  {
            ZStack {
                ScrollView(showsIndicators: false) {
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("Sukhpreet")
                                .font(.title)
                                .bold()
                            Text("Singh")
                                .font(.title)
                                .bold()
                        }
                        
                        Spacer()
                        Image(systemName: Constants.Images.personFill)
                            .font(.system(size: 100))
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    
                    Divider()
                    
                    VStack (alignment:.leading){
                        Text("Date of birth:")
                            .font(.title2)
                            .bold()
                            .padding(.vertical)
                        HStack {
                            Image(systemName: "calendar.circle")
                                .font(.largeTitle)
                            Text("12-12-1999")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    VStack (alignment:.leading){
                        Text("Address:")
                            .font(.title2)
                            .bold()
                            .padding(.vertical)
                        HStack {
                            Image(systemName: "map.circle")
                                .font(.largeTitle)
                            Text("Mohali, phase 5")
                                .fontWeight(.semibold)

                            Spacer()
                        }
                    }
                    VStack (alignment:.leading){
                        Text("Phone number:")
                            .font(.title2)
                            .bold()
                            .padding(.vertical)
                        HStack {
                            Image(systemName: "phone.circle")
                                .font(.largeTitle)
                            Text("9888802022")
                                .fontWeight(.semibold)

                            Spacer()
                        }
                    }
                    .padding(.bottom)
                    
                    Divider()
                        .padding(.vertical)
                    Button(action: {
                        viewModel.showEditProfileView.toggle()
                    }) {
                        HStack {
                            Image(systemName: Constants.Images.edit)
                                .font(.title2)
                            .foregroundColor(Constants.Colors.blueThemeColor)
                            Text(Constants.Labels.editProfileWithSpace)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                    }
                    .fullScreenCover(isPresented: $viewModel.showEditProfileView) {
                        EditUserProfileView(viewModel: viewModel)
                    }
                    
                    Button(action: {
                        print("open the settings")
                    }) {
                        HStack {
                            Image(systemName: Constants.Images.settings)
                                .font(.title2)
                            .foregroundColor(Constants.Colors.blueThemeColor)
                            Text(Constants.Labels.settings)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                    }
                    .padding(.vertical)
                    
                    Button(action: {
                        viewModel.showSignoutAlert.toggle()
                        
                    }) {
                        HStack {
                            Image(systemName: Constants.Images.logout)
                                .font(.title2)
                                .foregroundColor(.red)
                            Text(Constants.Labels.logOut)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text(""), message: Text(viewModel.alertMessage),
                            dismissButton: .default(Text(Constants.Labels.ok)
                                .foregroundColor(Constants.Colors.blueThemeColor)))
                    }
                    .alert(isPresented: $viewModel.showSignoutAlert) {
                        Alert(title: Text(Constants.Labels.Questions.logout), primaryButton: .cancel(Text(Constants.Labels.Alerts.cancel)), secondaryButton: .default(Text(Constants.Labels.ok)) {
                            viewModel.signOutCall()
                        })
                    }
                    if viewModel.isLoggedOut {
                        LoadingView()
                    }
                }
                .padding()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: MainTabViewModel())
    }
}
