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
        
        if viewModel.guestLogin {
            LoginSignupView()
        }
        else if viewModel.userLogin {
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
                                    AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .clipShape(Circle())
                                        case .failure(_):
                                            Image(systemName: Constants.Images.personFill)
                                                .font(.system(size: 100))
                                                .frame(width: 100, height: 100)
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .foregroundColor(.gray)
                                        @unknown default:
                                            EmptyView()
                                        }                            }
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
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: MainTabViewModel())
    }
}
