//
//  EditUserProfileView.swift
//  EventPlanner
//
//  Created by Chicmic on 01/06/23.


import SwiftUI
import _PhotosUI_SwiftUI

struct EditUserProfileView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    //MARK: DISMISS BUTTON
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: Constants.Images.xmark)
                            .font(.title)
                            .foregroundColor(Constants.Colors.blueThemeColor)
                        Spacer()
                    }
                }
                .padding(.vertical)
                
                Text(Constants.Labels.editProfile)
                    .font(.title)
                    .fontWeight(.semibold)
                
                ZStack(alignment: .bottomTrailing) {
                    
                    //MARK: PROFILE IMAGE
                    if let image = viewModel.imagePicker.image {
                        Image(uiImage:image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    else if let imageUrl = viewModel.userProfile.profile_image , !imageUrl.isEmpty {
                       AsyncImageCircularView(imageUrl: Constants.API.URLs.baseUrl + imageUrl)
                    }
                    else {
                        Image(systemName: Constants.Images.personFill)
                            .font(.system(size: 100))
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                    }
                    PhotosPicker(selection: $viewModel.imagePicker.imageSelection, matching: .images) {
                        Image(systemName: Constants.Images.edit)
                            .padding(4)
                            .foregroundColor(.white)
                            .background(Constants.Colors.blueThemeColor)
                            .clipShape(Circle())
                    }
                }
                .frame(width: 100, height: 100)
                
                ProfileFieldsView(viewModel: viewModel)
                
                //MARK: UPDATE PROFILE BUTTON
                Button {
                    print("")
                    viewModel.showEditProfileActionSheet.toggle()
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(viewModel.buttonDisabled ? .gray : Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text(Constants.Labels.done)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(viewModel.buttonDisabled)
                .padding(.top, 30)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text(""), message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text(Constants.Labels.ok)
                            .foregroundColor(Constants.Colors.blueThemeColor)))
                }
                .actionSheet(isPresented: $viewModel.showEditProfileActionSheet) {
                    ActionSheet(title: Text(Constants.Labels.Questions.updateProfile), message: nil, buttons: [
                        .default(Text(Constants.Labels.updateProfile),action: {
                            viewModel.updateUserProfile()
                        }),
                        .cancel()
                    ]
                    )
                }
            }
            .padding()
            
            if viewModel.editProfileLoading {
                LoadingView()
            }
        }
        .onTapGesture {
                    UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
                }
    }
}


struct EditUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserProfileView(viewModel: MainTabViewModel())
    }
}
