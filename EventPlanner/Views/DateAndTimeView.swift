//
//  DateAndTimeView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI

struct DateAndTimeView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        
        ScrollView {
            VStack {
                DateTimePickerView(viewModel: viewModel)
                
                if viewModel.actionType == .createEvent {
                    NavigationLink(destination: SearchLocationView(viewModel: viewModel)) {
                        ZStack {
                            Rectangle()
                                .frame(height: 50)
                                .foregroundColor( Constants.Colors.blueThemeColor)
                                .cornerRadius(10)
                            Text( Constants.Labels.Continue)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .padding()
                    }
                }
                else {
                    Button {
                        // show action sheet
                        viewModel.showActionSheet.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 50)
                                .foregroundColor( Constants.Colors.blueThemeColor)
                                .cornerRadius(10)
                            Text( Constants.Labels.Continue)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .padding()
                    }
                    .actionSheet(isPresented: $viewModel.showActionSheet) {
                        ActionSheet(title: Text(Constants.Labels.Questions.location), message: nil, buttons: [
                            .cancel(),
                            .default(Text(Constants.Labels.useSameLocation), action: {
                                // update the event with same location
                                // call the update event method here and pop the sheet
                                viewModel.updateEvent()
                                //viewModel.showEditSheet.toggle()
                            }),
                            .default(Text(Constants.Labels.changeLocation), action: {
                                //continue to the search location view
                                viewModel.showLocationView.toggle()
                            })
                        ]
                        )
                    }
                    
                    NavigationLink("", destination: SearchLocationView(viewModel: viewModel), isActive: $viewModel.showLocationView)
                }
            }
        }
    }
}

struct DateAndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateAndTimeView(viewModel: MainTabViewModel())
    }
}
