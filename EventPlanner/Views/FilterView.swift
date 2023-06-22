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
    
    var filterButtonDisabled : Bool {
        var bool: Bool = false
        for check in viewModel.checks {
            bool = bool || check
        }
        return !bool
    }

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
                    }
                    .padding([.leading, .top])
                    
                    
                   
                    DatePicker("", selection: $viewModel.filter.startDate, in: viewModel.startDate2..., displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.horizontal)
                        .accentColor(Constants.Colors.blueThemeColor)
                    
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
                            .foregroundColor(filterButtonDisabled ? .gray : Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text("Show results")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(filterButtonDisabled)
            }
            .onTapGesture {
                        UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
                    }
            .padding()
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        viewModel.resetFilter()
                    }
                    .foregroundColor(Constants.Colors.blueThemeColor)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
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
