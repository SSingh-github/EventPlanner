//
//  ProfileFieldsView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct ProfileFieldsView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text(Constants.Labels.Questions.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                TextFieldView(placeholder: Constants.Labels.Placeholders.firstName, text: $viewModel.userProfile.first_name)
                    .autocapitalization(.words)
                if viewModel.showFirstNameWarning() {
                    Text(Constants.Labels.Warnings.name)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                TextFieldView(placeholder: Constants.Labels.Placeholders.lastName, text: $viewModel.userProfile.last_name)
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
           TextFieldView(placeholder: Constants.Labels.Placeholders.phoneNumber, text: $viewModel.userProfile.phone_number)
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
            
            DatePickerTextFieldView(label: Constants.Labels.selectDOB, placeholder: Constants.Labels.Placeholders.selectDate, date: $viewModel.dateOfBirth, minimumDate: nil, pickerType: .date)
                .padding(.trailing)
            Text(Constants.Labels.Questions.address)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            TextFieldView(placeholder: Constants.Labels.Placeholders.address, text: $viewModel.userProfile.address)
        }
        .padding(.vertical)
    }
}