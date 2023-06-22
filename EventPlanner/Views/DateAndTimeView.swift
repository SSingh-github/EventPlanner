//
//  DateAndTimeView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI

struct DateAndTimeView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    @State var showActionSheet = false
    @State var showLocationView = false
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
                        showActionSheet.toggle()
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
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text("Do you want to use the same location?"), message: nil, buttons: [
                            .cancel(),
                            .default(Text("Use same location"), action: {
                                // update the event with same location
                                // call the update event method here and pop the sheet
                                viewModel.updateEvent()
                                //viewModel.showEditSheet.toggle()
                            }),
                            .default(Text("Change location"), action: {
                                //continue to the search location view
                                showLocationView.toggle()
                            })
                        ]
                        )
                    }
                    
                    NavigationLink("", destination: SearchLocationView(viewModel: viewModel), isActive: $showLocationView)
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
