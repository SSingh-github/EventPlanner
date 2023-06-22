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
                                // Show the image using the URL
                                AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        // Placeholder view while the image is being loaded
                                        ProgressView()
                                    case .success(let image):
                                        // Display the loaded image
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    case .failure(_):
                                        // Show an error placeholder if the image fails to load
                                        Image(systemName: Constants.Images.personFill)
                                            .font(.system(size: 100))
                                            .frame(width: 100, height: 100)
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        // Handle any future cases if needed
                                        EmptyView()
                                    }                            }
                            } else {
                                // Show a default image when the URL is empty or nil
                                Image(systemName: Constants.Images.personFill)
                                    .font(.system(size: 100))
                                    .frame(width: 100, height: 100)
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Divider()
                        
                        VStack (alignment:.leading){

                            HStack {
                                Image(systemName: Constants.Images.phone)
                                    .font(.title3)
                                Text(String(viewModel.userProfile.phone_number))
                                    //.fontWeight(.semibold)

                                Spacer()
                            }
                        }
                        .padding(.bottom)
                        
                        VStack (alignment:.leading){
                            HStack {
                                Image(systemName: Constants.Images.calendar)
                                    .font(.title3)
                                Text(viewModel.userProfile.dob == "" ? "2000-02-02" : viewModel.userProfile.dob)
                                    //.fontWeight(.semibold)
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
                            ActionSheet(title: Text("Do you want to log out?"), message: nil, buttons: [ // 4
                                .destructive(Text("Logout").foregroundColor(.red), action: { // 5
                                    viewModel.signOutCall()
                                }),
                                .cancel() // 6
                            ]
                            )
                        }
                        
                    }
                    .refreshable {
                        NetworkManager.shared.getUserProfileDetails(viewModel: viewModel)
                    }
                    .padding()
                    if viewModel.isLoggedOut {
                        LoadingView()
                    }
                }
                .navigationTitle("Profile")
                .onAppear {
                    if viewModel.userProfile.first_name == "" {
                        NetworkManager.shared.getUserProfileDetails(viewModel: viewModel)
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
