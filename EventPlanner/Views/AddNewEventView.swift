//
//  AddNewEventView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//
//hashtags are not working
//i am changing the field to the object

import SwiftUI
import _PhotosUI_SwiftUI

struct AddNewEventView: View {
    
    //@StateObject var viewModel = MainTabViewModel()
    @ObservedObject var viewModel: MainTabViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var buttonDisabled: Bool {
        if viewModel.actionType == .createEvent {
            var bool: Bool = false
            bool = bool || viewModel.newEvent.title.isEmpty
            bool = bool || viewModel.newEvent.hashtags.isEmpty
            bool = bool || viewModel.newEvent.selectedOption == nil
            bool = bool || viewModel.newEvent.imagePicker2.image == nil
            return bool
        }
        else {
            var bool: Bool = false
            bool = bool || viewModel.newEventForEdit.title.isEmpty
            bool = bool || viewModel.newEventForEdit.hashtags.isEmpty
            bool = bool || viewModel.newEventForEdit.selectedOption == nil
            bool = bool || viewModel.newEventForEdit.imagePicker2.image == nil
            print("button is disabled \(bool)")
            return bool
        }
    }
    
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
                if viewModel.actionType == .createEvent {
                    TextFieldView(placeholder: "Title", text: $viewModel.newEvent.title)
                }
                else {
                    TextFieldView(placeholder: "Title", text: $viewModel.newEventForEdit.title)
                }
                
                
                
                HStack {
                    Text("Give the description")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                
                TextField("Description", text:viewModel.actionType == .createEvent ? $viewModel.newEvent.description : $viewModel.newEventForEdit.description, axis: .vertical)
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
                    
                    TextFieldWithPickerAsInputView(data: Constants.Labels.eventTypes, placeholder: "Select Category", selectionIndex: $viewModel.selectionIndex2, text:viewModel.actionType == .createEvent ? $viewModel.newEvent.selectedOption : $viewModel.newEventForEdit.selectedOption)
                    
                        .fontWeight(.semibold)
                        .accentColor(Constants.Colors.blueThemeColor)
                }
                
                
                
                ZStack {
                    
                    if let image = viewModel.actionType == .createEvent ? viewModel.newEvent.imagePicker2.image :
                        viewModel.newEventForEdit.imagePicker2.image {
                        Image(uiImage:image)
                            .resizable()
                            .frame(height: 250)
                            .scaledToFit()
                            .cornerRadius(20)
                        
                        PhotosPicker(selection:viewModel.actionType == .createEvent ? $viewModel.newEvent.imagePicker2.imageSelection : $viewModel.newEventForEdit.imagePicker2.imageSelection , matching: .images) {
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
                        PhotosPicker(selection:viewModel.actionType == .createEvent ? $viewModel.newEvent.imagePicker2.imageSelection : $viewModel.newEventForEdit.imagePicker2.imageSelection, matching: .images) {
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
                        if viewModel.actionType == .createEvent {
                            ForEach(viewModel.newEvent.hashtags.indices, id: \.self) { index in
                                HStack {
                                    TextFieldView(placeholder: "# hashtag", text: $viewModel.newEvent.hashtags[index])
                                    Button {
                                        viewModel.newEvent.hashtags.remove(at: index)
                                    } label: {
                                        Image(systemName: Constants.Images.multiply)
                                            .font(.title3)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        else {
                            ForEach(viewModel.newEventForEdit.hashtags.indices, id: \.self) { index in
                                HStack {
                                    TextFieldView(placeholder: "# hashtag", text: $viewModel.newEventForEdit.hashtags[index])
                                    Button {
                                        viewModel.newEventForEdit.hashtags.remove(at: index)
                                    } label: {
                                        Image(systemName: Constants.Images.multiply)
                                            .font(.title3)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                    }
                    HStack {
                        Button {
                            withAnimation {
                                if viewModel.actionType == .createEvent {
                                    viewModel.newEvent.hashtags.append("")
                                }
                                else {
                                    viewModel.newEventForEdit.hashtags.append("")
                                }
                            }
                            print(viewModel.newEvent.hashtags.count)
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
                            .foregroundColor(buttonDisabled ? .gray : Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text("Continue")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(buttonDisabled)
            }
            .padding()
            .navigationTitle(viewModel.actionType == .createEvent ? "Create Event" : "Update Event")
            .onTapGesture {
                        UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
                    }
        }
       
    }
}

struct AddNewEventView_Previews: PreviewProvider {
    static var previews: some View {
       
            AddNewEventView(viewModel: MainTabViewModel())

    }
}
