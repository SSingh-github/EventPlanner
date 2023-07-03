//
//  EventDetailsView.swift
//  EventPlanner
//
//  Created by Chicmic on 08/06/23.


import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var indexOfEvent: Int = 0
    var eventType: EventType = .all

    var id: Int {
        switch eventType {
        case .all:
            return viewModel.events[indexOfEvent].id
        case .favourite:
            return viewModel.favouriteEvents[indexOfEvent].id
        case .joined:
            return viewModel.joinedEvents[indexOfEvent].id
        case .created:
            return viewModel.myEvents[indexOfEvent].id
        }
    }

    var body: some View {
    
        ZStack {
            ScrollView(showsIndicators: false) {
                    VStack {
                        
                        Text(viewModel.detailedEventForExplore?.title ?? Constants.Labels.noTitle)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4)
                        Text(viewModel.detailedEventForExplore?.is_approved ?? true ? Constants.Labels.approvedLable : Constants.Labels.notApprovedLable)
                            .foregroundColor(viewModel.detailedEventForExplore?.is_approved ?? true ? .green : .red)
                    }
                    .padding(.bottom, 20)
                
                    UpperEventDetailsView(viewModel: viewModel)
                
                    HStack {
                        Text(Constants.Labels.Commencement)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName:Constants.Images.calendar)
                            Text(viewModel.detailedEventForExplore?.start_date ?? "")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: Constants.Images.clock)
                            Text(Formatter.shared.convertTo12HourFormat(timeString: viewModel.detailedEventForExplore?.start_time ?? "") ?? Constants.Labels.invalid)
                            Spacer()
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text(Constants.Labels.culmination)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: Constants.Images.calendar)
                            Text(viewModel.detailedEventForExplore?.end_date ?? "")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: Constants.Images.clock)
                            Text(Formatter.shared.convertTo12HourFormat(timeString: viewModel.detailedEventForExplore?.end_time ?? "") ?? Constants.Labels.invalid)
                            Spacer()
                        }
                    }
                    
                    Divider()
                    
                   EventBarView(viewModel: viewModel)
            
                //MARK: JOIN EVENT BUTTON
                    Button {
                        viewModel.showJoinEventActionSheet.toggle()
                    } label: {
                        if !(viewModel.detailedEventForExplore?.is_joined ?? true) {
                            ZStack {
                                Rectangle()
                                    .frame(height: 60)
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                                    .cornerRadius(10)
                                Text(Constants.Labels.joinEvent)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                        else {
                            ZStack {
                                Rectangle()
                                    .frame(height: 60)
                                    .foregroundColor(.green)
                                    .cornerRadius(10)
                                Text(Constants.Labels.joined)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .actionSheet(isPresented: $viewModel.showJoinEventActionSheet) {
                        ActionSheet(title:viewModel.detailedEventForExplore!.is_joined ? Text(Constants.Labels.Questions.leaveEvent): Text(Constants.Labels.Questions.joinEvent), message: nil, buttons: [
                            .default(viewModel.detailedEventForExplore!.is_joined ? Text(Constants.Labels.leave) : Text(Constants.Labels.join),action: {
                                viewModel.joinEvent(id: id)
                                viewModel.detailedEventForExplore!.is_joined.toggle()
                                if viewModel.detailedEventForExplore!.is_joined {
                                    viewModel.detailedEventForExplore!.event_attendees_count += 1
                                }
                                else {
                                    viewModel.detailedEventForExplore!.event_attendees_count -= 1
                                }
                            }),
                            .cancel()
                        ]
                        )
                    }
                    .frame(height: 60)
                    .padding(.top, 40)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .padding()
            
            if viewModel.showDetailedEventForExplore {
                LoadingView()
            }
        }
        .onDisappear {
            viewModel.detailedEventForExplore = nil
        }
        .onAppear {
            viewModel.getEventDetails(eventType: eventType, indexOfEvent: indexOfEvent)
        }
        .toolbar {
            if eventType == .created {
                Button {
                    viewModel.eventForEdit = viewModel.myEvents[indexOfEvent]
                    viewModel.actionType = .updateEvent
                    viewModel.createNewEventForEdit(event: viewModel.myEvents[indexOfEvent])
                    viewModel.showEditSheet.toggle()
                } label: {
                    Text(Constants.Labels.edit)
                }.sheet(isPresented: $viewModel.showEditSheet, onDismiss: {
                    viewModel.actionType = .createEvent
                    viewModel.newEventForEdit = NewEvent()
                }) {
                    AddNewEventView(viewModel: viewModel)
                }
            }
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(viewModel: MainTabViewModel())
    }
}
