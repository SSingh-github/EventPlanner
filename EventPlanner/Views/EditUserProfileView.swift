//
//  EditUserProfileView.swift
//  EventPlanner
//
//  Created by Chicmic on 01/06/23.


import SwiftUI

struct EditUserProfileView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                Image(systemName: Constants.Images.personFill)
                    .font(.system(size: 100))
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(Circle())
                    .foregroundColor(.gray)
                Button {
                    print("change profile pic")
                } label: {
                    Image(systemName: Constants.Images.edit)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(Constants.Colors.blueThemeColor)
                        .clipShape(Circle())
                }

            }
            .frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
                
                Text(Constants.Labels.Questions.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                TextFieldView(placeholder: Constants.Labels.Placeholders.firstName, text: $viewModel.firstName)
                TextFieldView(placeholder: Constants.Labels.Placeholders.lastName, text: $viewModel.lastName)
                Text(Constants.Labels.Questions.phone)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                TextFieldView(placeholder: Constants.Labels.Placeholders.phoneNumber, text: $viewModel.phoneNumber)
                Text(Constants.Labels.Questions.dob)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                TextFieldView(placeholder: Constants.Labels.Placeholders.dob, text: $viewModel.dob)
                Text(Constants.Labels.Questions.address)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                TextFieldView(placeholder: Constants.Labels.Placeholders.address, text: $viewModel.address)
            }
            .padding(.vertical)
            
            Button {
                print("")
                
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
        }
        .padding()
    }
}

struct EditUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserProfileView(viewModel: MainTabViewModel())
    }
}