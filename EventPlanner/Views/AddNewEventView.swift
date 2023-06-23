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
    
   
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false){
                
                HStack {
                    Text(Constants.Labels.Questions.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                if viewModel.actionType == .createEvent {
                    TextFieldView(placeholder: Constants.Labels.title, text: $viewModel.newEvent.title)
                }
                else {
                    TextFieldView(placeholder: Constants.Labels.title, text: $viewModel.newEventForEdit.title)
                }
                
                
                
                HStack {
                    Text(Constants.Labels.giveDescription)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                
                TextField(Constants.Labels.description, text:viewModel.actionType == .createEvent ? $viewModel.newEvent.description : $viewModel.newEventForEdit.description, axis: .vertical)
                    .disableAutocorrection(true)
                    .padding()
                    .frame(height: 60)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .accentColor(Constants.Colors.blueThemeColor)
                
                HStack {
                    Text(Constants.Labels.category)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    
                    TextFieldWithPickerAsInputView(data: Constants.Labels.eventTypes, placeholder: Constants.Labels.Placeholders.selectCategory, selectionIndex: $viewModel.selectionIndex2, text:viewModel.actionType == .createEvent ? $viewModel.newEvent.selectedOption : $viewModel.newEventForEdit.selectedOption)
                    
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
                                    Image(systemName: Constants.Images.photoRectangle)
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
                            Image(systemName: Constants.Images.photoRectangle)
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
                                    TextFieldView(placeholder: Constants.Labels.Placeholders.hashtag, text: $viewModel.newEvent.hashtags[index])
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
                                    TextFieldView(placeholder: Constants.Labels.Placeholders.hashtag, text: $viewModel.newEventForEdit.hashtags[index])
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
                            Image(systemName: Constants.Images.addHashtag)
                                .foregroundColor(.green)
                                .font(.title3)
                        }
                        Text(Constants.Labels.addHashtag)
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
                            .foregroundColor(viewModel.buttonDisabled2 ? .gray : Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text(Constants.Labels.Continue)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .disabled(viewModel.buttonDisabled2)
            }
            .padding()
            .navigationTitle(viewModel.actionType == .createEvent ? Constants.Labels.createEvent : Constants.Labels.updateEvent)
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
