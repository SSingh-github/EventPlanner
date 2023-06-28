//
//  AddNewEventView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct AddNewEventView: View {
    
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
                
                //MARK: TITLE FIELD
                viewModel.actionType == .createEvent ? TextFieldView(placeholder: Constants.Labels.title, text: $viewModel.newEvent.title) : TextFieldView(placeholder: Constants.Labels.title, text: $viewModel.newEventForEdit.title)

                HStack {
                    Text(Constants.Labels.giveDescription)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
                
                //MARK: DESCRIPTION FIELD
                TextFieldView(placeholder: Constants.Labels.description, text: viewModel.actionType == .createEvent ? $viewModel.newEvent.description : $viewModel.newEventForEdit.description, axis: .vertical)
                
                HStack {
                    Text(Constants.Labels.category)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    
                    //MARK: CATEGORY PICKER
                    TextFieldWithPickerAsInputView(data: Constants.Labels.eventTypes, placeholder: Constants.Labels.Placeholders.selectCategory, selectionIndex: $viewModel.selectionIndex2, text:viewModel.actionType == .createEvent ? $viewModel.newEvent.selectedOption : $viewModel.newEventForEdit.selectedOption)
                    
                        .fontWeight(.semibold)
                        .accentColor(Constants.Colors.blueThemeColor)
                }
                ZStack {
                    //MARK: EVENT IMAGE
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
                    viewModel.actionType == .createEvent ? HashTags(hashtags: $viewModel.newEvent.hashtags) : HashTags(hashtags: $viewModel.newEventForEdit.hashtags)
                    HStack {
                        
                        //MARK: CREATE EVENT BUTTON
                        Button {
                            withAnimation {
                                viewModel.actionType == .createEvent ? viewModel.newEvent.hashtags.append("") : viewModel.newEventForEdit.hashtags.append("")
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
                NavLink(buttonDisabled: viewModel.buttonDisabled2) {
                    DateAndTimeView(viewModel: viewModel)
                }
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
