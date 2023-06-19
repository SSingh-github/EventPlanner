//
//  AddNewEventView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//
//hashtags are not working

import SwiftUI
import _PhotosUI_SwiftUI

struct AddNewEventView: View {
    
    @StateObject var viewModel = AddEventViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false){
            
                HStack {
                    Text("What's the title?")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                    Spacer()
                }
                    TextFieldView(placeholder: "Title", text: $viewModel.title)
                    
                   
                    
                HStack {
                    Text("Give the description")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                    Spacer()
                }
                   
                       // .padding()
                    
                TextField("Description", text: $viewModel.description, axis: .vertical)
                    .disableAutocorrection(true)
                    .padding()
                    .frame(height: 60)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .accentColor(Constants.Colors.blueThemeColor)
                
                HStack {
                    Text("Category")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    
//                    Picker("Select an option", selection: $viewModel.selectedOption) {
//                        ForEach(Constants.Labels.eventTypes, id: \.self) { eventType in
//                            Text(eventType)
//                                .padding()
//                        }
//                    }
//                    .pickerStyle(.inline)
//                    .fontWeight(.semibold)
                    
                    TextFieldWithPickerAsInputView(data: Constants.Labels.eventTypes, placeholder: "Select Category", selectionIndex: $viewModel.selectionIndex, text: $viewModel.selectedOption)
                    //.frame(maxWidth: .infinity)
                    //.padding()
                    .fontWeight(.semibold)
                    .accentColor(Constants.Colors.blueThemeColor)
                }
                
                
                
                ZStack {
                    
                    if let image = viewModel.imagePicker.image {
                        Image(uiImage:image)
                             .resizable()
                             .frame(height: 250)
                             .scaledToFit()
                             .cornerRadius(20)
                        
                        PhotosPicker(selection: $viewModel.imagePicker.imageSelection, matching: .images) {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "photo.on.rectangle")
                                        .font(.subheadline)
                                        .padding(15)
                                        .foregroundColor(.black)
                                        .background(.white)
                                        .clipShape(Circle())
                                }
                                .padding()
                            }
                            .frame(height: 250)
                        }
                    }
                    else {
                        Rectangle()
                            .frame(height: 250)
                            .cornerRadius(20)
                            .foregroundColor(.secondary)
                        PhotosPicker(selection: $viewModel.imagePicker.imageSelection, matching: .images) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.largeTitle)
                                .padding(15)
                                .foregroundColor(.black)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                    
                   
                    
                }
                    
                    VStack(spacing: 10) {
                        VStack {
                            ForEach(viewModel.hashtags.indices, id: \.self) { index in
                                HStack {
                                    TextFieldView(placeholder: "# hashtag", text: $viewModel.hashtags[index])
                                    Button {
                                        viewModel.hashtags.remove(at: index)
                                    } label: {
                                        Image(systemName: Constants.Images.multiply)
                                            .font(.title3)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        HStack {
                            Button {
                                withAnimation {
                                    viewModel.hashtags.append("")
                                }
                                print(viewModel.hashtags.count)
                            }label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title3)
                            }
                            Text("Add Hashtag")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding()
                            Spacer()
                        }
                        .padding()
                        
                    }
                    .padding(.top)
                    Spacer()
                    NavigationLink(destination: DateAndTimeView(viewModel: viewModel)) {
                        ZStack {
                            Rectangle()
                                .frame(height: 60)
                                .foregroundColor(Constants.Colors.blueThemeColor)
                                .cornerRadius(10)
                            Text("Continue")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
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
