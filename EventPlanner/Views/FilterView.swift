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
                        Text("Category")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding([.trailing, .top,.bottom])
                        Spacer()
                        
//                        Picker("Select an option", selection: $viewModel.filter.eventCategory) {
//                            ForEach(Constants.Labels.eventTypes, id: \.self) { eventType in
//                                Text(eventType)
//                                    .padding()
//                            }
//                        }
//                        .pickerStyle(WheelPickerStyle())
                        
                        TextFieldWithPickerAsInputView(data: Constants.Labels.eventTypes, placeholder: "Select Category", selectionIndex: $viewModel.selectionIndex, text: $viewModel.filter.eventCategory)
                        //.frame(maxWidth: .infinity)
                        //.padding()
                        .fontWeight(.semibold)
                        .accentColor(Constants.Colors.blueThemeColor)
                    }
                    //.padding(.horizontal)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(colorScheme == .light ? Color.black.opacity(1) : Color.white.opacity(1), lineWidth: 2)
//                            .frame(height: CGFloat(60))
//                    )
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[1])

                        Text("Start Date:")
                            .font(.title3)
                            .fontWeight(.semibold)
                            
                        Spacer()
                    }
                    .padding([.leading, .top])
                    
                    
                   
                    DatePicker("", selection: $viewModel.filter.startDate, in: viewModel.startDate..., displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.horizontal)
                        .accentColor(Constants.Colors.blueThemeColor)
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[2])

                        Text("Title:")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding([.leading, .top])

                    
                    TextFieldView(placeholder: "Event title", text: $viewModel.filter.title)
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[3])

                        Text("Hashtag:")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding([.leading, .top])

                    
                    TextFieldView(placeholder: "#tag", text: $viewModel.filter.hashtag)
                    
                    HStack {
                        CheckBoxView(checked: $viewModel.checks[4])

                        Text("Radius: " + String(format: "%.1f", viewModel.filter.radius) + " Km")
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

                            Text("Location:")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding([.leading, .top])

                        TextFieldView(placeholder: "Location", text: $viewModel.filter.location)
                            .padding(.bottom)

                    }
                    
                }
                Spacer()
                Button {
                    // when this button is clicked the search results must be loaded again
                    viewModel.getFilteredEvents()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 60)
                            .foregroundColor(Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text("Show results")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
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
