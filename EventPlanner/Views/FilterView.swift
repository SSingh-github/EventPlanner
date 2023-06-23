//
//  FilterView.swift
//  EventPlanner
//
//  Created by Chicmic on 12/06/23.
//

import SwiftUI

struct FilterView: View {

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MainTabViewModel
    
    

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: false) {
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[0])
                            .padding(.leading)
                        Text(Constants.Labels.category)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding([.trailing, .top,.bottom])
                        Spacer()
                        
                        
                        TextFieldWithPickerAsInputView(data: Constants.Labels.eventTypes, placeholder: Constants.Labels.selectCategory, selectionIndex: $viewModel.selectionIndex, text: $viewModel.filter.eventCategory)
                        
                            .fontWeight(.semibold)
                            .accentColor(Constants.Colors.blueThemeColor)
                    }

                    HStack {
                        CheckBoxView(checked: $viewModel.checks[1])

                        Text(Constants.Labels.startDate)
                            .font(.title3)
                            .fontWeight(.semibold)
                            
                        Spacer()
                        
                         DatePicker("", selection: $viewModel.filter.startDate, displayedComponents: .date)
                            .datePickerStyle(.automatic)
                             .padding(.horizontal)
                             .accentColor(Constants.Colors.blueThemeColor)
                             .cornerRadius(20)
                    }
                    .padding([.leading, .top])
                    
                    
                   
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[2])

                        Text(Constants.Labels.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding([.leading, .top])

                    
                    TextFieldView(placeholder: Constants.Labels.Placeholders.eventTitle, text: $viewModel.filter.title)
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[3])

                        Text(Constants.Labels.hashtag)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding([.leading, .top])

                    
                    TextFieldView(placeholder: Constants.Labels.Placeholders.tag, text: $viewModel.filter.hashtag)
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[4])

                        Text(Constants.Labels.radius + String(format: Constants.StringFormats.float, viewModel.filter.radius) + Constants.Labels.km)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding([.leading, .top])

                    .padding(.top)
                    Slider(value: $viewModel.filter.radius, in: 5...100)
                        .accentColor(Constants.Colors.blueThemeColor)
                    
                    VStack {
                        HStack {
                            CheckBoxView(checked: $viewModel.checks[5])

                            Text(Constants.Labels.location)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding([.leading, .top])

                        TextFieldView(placeholder: Constants.Labels.Placeholders.location, text: $viewModel.filter.location)
                            .padding(.bottom)

                    }
                    
                }
                Spacer()
                Button {
                    viewModel.getFilteredEvents()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(viewModel.filterButtonDisabled ? .gray : Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text(Constants.Labels.showResults)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(viewModel.filterButtonDisabled)
            }
            .onTapGesture {
                        UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
                    }
            .padding()
            .navigationTitle(Constants.Labels.filter)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(Constants.Labels.reset) {
                        viewModel.resetFilter()
                    }
                    .foregroundColor(Constants.Colors.blueThemeColor)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(Constants.Labels.cancel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Constants.Colors.blueThemeColor)
                }
            }
        }
    }
    
    
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: MainTabViewModel())
    }
}
