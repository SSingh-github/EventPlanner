//
//  CreateProfileView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct CreateProfileView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                Text(Constants.Labels.createProfile)
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
                            .autocapitalization(.words)
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
                        .keyboardType(.numberPad)
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
                    viewModel.buttonClicked()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor( Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text(Constants.Labels.signUp)
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
            
            if viewModel.isLoggedIn {
                LoadingView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(viewModel: LoginViewModel())
    }
}
