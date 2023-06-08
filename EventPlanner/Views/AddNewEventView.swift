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
    @StateObject var locationManager = LocationManager()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            
                VStack(spacing: 20) {
            
                    Picker("Select an option", selection: $viewModel.selectedOption) {
                        ForEach(Constants.Labels.eventTypes, id: \.self) { eventType in
                            Text(eventType)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .fontWeight(.semibold)
                    .accentColor(colorScheme == .dark ? .white : .black)
                    Text("latitude is \(locationManager.userLocation?.coordinate.latitude ?? 0)")
                    Text("longitude \(locationManager.userLocation?.coordinate.longitude ?? 0)")
                    
                    TextField("Title", text: $viewModel.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                       // .padding()
                    
                    TextField("Description", text: $viewModel.description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        //.padding()
                    
                    ZStack(alignment: .bottomTrailing) {
                        
                        if let image = viewModel.imagePicker.image {
                            Image(uiImage:image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        }
                        else {
                            Circle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(colorScheme == .light ? .white : .black
                                )
                                .shadow(color:colorScheme == .light ?.black : .white, radius: 5)
                            
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 40))
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                                .clipShape(Circle())
                                
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
                                print(viewModel.hashtags.count)
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
                        .listStyle(PlainListStyle())
                        
                        //Spacer()
                    }
                    //.padding()
                    Spacer()
                    NavigationLink(destination: DateAndTimeView(viewModel: viewModel)) {
                        Text("continue")
                    }
                }
                .padding()
            //.navigationTitle("Create Event")
            }
            
        
        
    }
}

struct AddNewEventView_Previews: PreviewProvider {
    static var previews: some View {
       
            AddNewEventView()

    }
}
