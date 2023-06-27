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
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack(alignment: .center) {
                            HStack {
                                Text(viewModel.userProfile.first_name)
                                    .font(.title2)
                                    .bold()
                                Text(viewModel.userProfile.last_name)
                                    .font(.title2)
                                    .bold()
                            }
                            
                            Spacer()
                            if let imageUrl = viewModel.userProfile.profile_image, !imageUrl.isEmpty {
                                AsyncImageCircularView(imageUrl: Constants.API.URLs.baseUrl + imageUrl)
                            } else {
                                Image(systemName: Constants.Images.personFill)
                                    .font(.system(size: 100))
                                    .frame(width: 100, height: 100)
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .foregroundColor(.gray)
                            }
                        }
                        VStack (alignment:.leading){
                            
                            HStack {
                                Image(systemName: Constants.Images.phone)
                                    .font(.title3)
                                Text(String(viewModel.userProfile.phone_number))
                                
                                Spacer()
                            }
                        }
                        .padding(.bottom)
                        
                        VStack (alignment:.leading){
                            HStack {
                                Image(systemName: Constants.Images.calendar)
                                    .font(.title3)
                                Text(viewModel.userProfile.dob == "" ? "" : viewModel.userProfile.dob)
                                Spacer()
                            }
                        }
                        .padding(.bottom)
                        
                        VStack (alignment:.leading){
                            HStack {
                                Image(Constants.Images.location)
                                    .font(.title)
                                Text(viewModel.userProfile.address)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(.secondary.opacity(0.2))
                    .cornerRadius(20)
                    
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
                    .padding(.top)
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text(""), message: Text(viewModel.alertMessage),
                            dismissButton: .default(Text(Constants.Labels.ok)
                                .foregroundColor(Constants.Colors.blueThemeColor)))
                    }
                }
                .actionSheet(isPresented: $viewModel.showSignoutAlert) {
                    ActionSheet(title: Text(Constants.Labels.Questions.logout), message: nil, buttons: [                             .destructive(Text(Constants.Labels.logOut).foregroundColor(.red), action: {
                        viewModel.signOutCall()
                    }),
                        .cancel()
                    ]
                    )
                }
                if viewModel.isLoggedOut {
                    LoadingView()
                }
                if viewModel.userProfileLoading {
                    LoadingView()
                }
            }
            .navigationTitle(Constants.Labels.profile)
            .refreshable {
                viewModel.getProfile()
            }
            .padding()
        }
        .onAppear {
            if viewModel.userProfile.first_name == "" {
                viewModel.getProfile()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: MainTabViewModel())
    }
}
