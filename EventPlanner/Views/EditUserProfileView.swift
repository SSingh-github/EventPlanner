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
                    
                    if let image = viewModel.imagePicker.image {
                        Image(uiImage:image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    else if let imageUrl = viewModel.imageUrl , !imageUrl.isEmpty {
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
                            }
                        }
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
                
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text(Constants.Labels.Questions.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top)
                        TextFieldView(placeholder: Constants.Labels.Placeholders.firstName, text: $viewModel.firstName)
                        if viewModel.showFirstNameWarning() {
                            Text(Constants.Labels.Warnings.name)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                        TextFieldView(placeholder: Constants.Labels.Placeholders.lastName, text: $viewModel.lastName)
                        if viewModel.showLastNameWarning() {
                            Text(Constants.Labels.Warnings.name)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                    }
                    
                    Text(Constants.Labels.Questions.phone)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    TextFieldView(placeholder: Constants.Labels.Placeholders.phoneNumber, text: $viewModel.phoneNumber)
                    if viewModel.showPhoneNumberWarning() {
                        Text(Constants.Labels.Warnings.phoneNumber)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                    }
                    
                    Text(Constants.Labels.Questions.dob)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    DatePicker(Constants.Labels.selectDob, selection: $viewModel.dateOfBirth,in:viewModel.startDate...viewModel.endDate, displayedComponents: .date)
                        .padding(.bottom)
                    
                    Text(Constants.Labels.Questions.address)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    TextFieldView(placeholder: Constants.Labels.Placeholders.address, text: $viewModel.address)
                }
                .padding(.vertical)
                
                Button {
                    print("")
                    viewModel.updateUserProfile()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor( Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text(Constants.Labels.done)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top, 30)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text(""), message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text(Constants.Labels.ok)
                            .foregroundColor(Constants.Colors.blueThemeColor)))
                }
            }
            .padding()
            
            if viewModel.editProfileLoading {
                LoadingView()
            }
        }
    }
}

struct EditUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserProfileView(viewModel: MainTabViewModel())
    }
}
