//
//  AddNewEventView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct AddNewEventView: View {
    
    @StateObject var viewModel = AddEventViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Drop-down for selecting between 5 strings
                Picker("Select an option", selection: $viewModel.selectedOption) {
                    ForEach(Constants.Labels.eventTypes, id: \.self) { eventType in
                        Text(eventType)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                .padding()
                
                // Field for adding a title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Field for adding a description
                TextField("Description", text: $viewModel.description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Image view containing the system image of a person
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
                
                VStack(spacing: 10) {
                    HStack {
                        Button {
                            viewModel.hashtags.append("")
                        }label: {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                        
                        
                        Text("Add Hashtag")
                    }
                    .padding()
                    
                    List {
                        ForEach(viewModel.hashtags.indices, id: \.self) { index in
                            TextField("Hashtag", text: $viewModel.hashtags[index])
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                Spacer()
                NavigationLink(destination: DateAndTimeView(viewModel: viewModel)) {
                    Text("continue")
                }
            }
            .padding()
            .navigationTitle("Create Event")
            
        }
        
    }
}

struct AddNewEventView_Previews: PreviewProvider {
    static var previews: some View {
       
            AddNewEventView()

    }
}
