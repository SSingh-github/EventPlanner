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
                    NavLink(buttonDisabled: viewModel.dateButtonDisabled) {
                        SearchLocationView(viewModel: viewModel)
                    }
                }
                else {
                    //MARK: CONTINUE BUTTON
                    Button {
                        viewModel.showActionSheet.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 60)
                                .foregroundColor(viewModel.dateButtonDisabled ? .gray : Constants.Colors.blueThemeColor)
                                .cornerRadius(10)
                            Text( Constants.Labels.Continue)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }.padding(.horizontal)
                    .disabled(viewModel.dateButtonDisabled)
                    .actionSheet(isPresented: $viewModel.showActionSheet) {
                        ActionSheet(title: Text(Constants.Labels.Questions.location), message: nil, buttons: [
                            .cancel(),
                            .default(Text(Constants.Labels.useSameLocation), action: {
                                
                                viewModel.updateEvent()
                               
                            }),
                            .default(Text(Constants.Labels.changeLocation), action: {
                               
                                viewModel.showLocationView.toggle()
                            })
                        ]
                        )
                    }
                    NavigationLink("", destination: SearchLocationView(viewModel: viewModel), isActive: $viewModel.showLocationView)
                }
            }
            .padding()
        }
    }
}

struct DateAndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateAndTimeView(viewModel: MainTabViewModel())
    }
}
