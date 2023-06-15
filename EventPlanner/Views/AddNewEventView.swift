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
                    
                    Picker("Select an option", selection: $viewModel.selectedOption) {
                        ForEach(Constants.Labels.eventTypes, id: \.self) { eventType in
                            Text(eventType)
                                .padding()
                        }
                    }
                    .pickerStyle(.inline)
                    .fontWeight(.semibold)
                }
                
                
                ZStack {
                    
                    if let image = viewModel.imagePicker.image {
                        Image(uiImage:image)
                             .resizable()
                             .frame(height: 250)
                             .scaledToFit()
                             .cornerRadius(20)
                    }
                    else {
                        Rectangle()
                            .frame(height: 250)
                            .cornerRadius(20)
                            .foregroundColor(.secondary)
                    }
                    
                    PhotosPicker(selection: $viewModel.imagePicker.imageSelection, matching: .images) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.largeTitle)
                            .padding(15)
                            .foregroundColor(.black)
                            .background(.white)
                            .clipShape(Circle())
                    }
                    
                }
//
//                    ZStack(alignment: .bottomTrailing) {
//
//                        if let image = viewModel.imagePicker.image {
//                            Image(uiImage:image)
//                                 .resizable()
//                                 .frame(height: 250)
//                                 .scaledToFit()
//                                 .cornerRadius(20)
//                        }
//                        else {
////                            Circle()
////                                .frame(width: 100, height: 100)
////                                .foregroundColor(colorScheme == .light ? .white : .black
////                                )
////                                .shadow(color:colorScheme == .light ?.black : .white, radius: 5)
//
////                            Image(systemName: "photo.on.rectangle")
////                                .font(.system(size: 40))
////                                .frame(width: 100, height: 100)
////                                .scaledToFit()
////                                .clipShape(Circle())
//
//                            Rectangle()
//                                 //.resizable()
//                                 .frame(height: 50)
//                                 .scaledToFit()
//                                 .cornerRadius(20)
//                                 .foregroundColor(.secondary)
//
//                        }
//                        PhotosPicker(selection: $viewModel.imagePicker.imageSelection, matching: .images) {
//                            Image(systemName: Constants.Images.edit)
//                                .padding(4)
//                                .foregroundColor(.white)
//                                .background(Constants.Colors.blueThemeColor)
//                                .clipShape(Circle())
//                        }
//                    }
                   // .frame(width: 100, height: 100)
                    
                    VStack(spacing: 10) {
                        VStack {
                            ForEach(viewModel.hashtags.indices, id: \.self) { index in
                                TextFieldView(placeholder: "# hashtag", text: $viewModel.hashtags[index])
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
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                                    .font(.title)
                            }
                            Text("Add Hashtag")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding()
                            Spacer()
                        }
                        .padding()
                        
                        
                        
                        
                        //Spacer()
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
