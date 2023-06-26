//
//  EventDetailsView.swift
//  EventPlanner
//
//  Created by Chicmic on 08/06/23.

// person.fill.badge.plus symbol to join the event


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
                        
                        Text(viewModel.detailedEventForExplore?.title ?? "no title")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4)
                        Text(viewModel.detailedEventForExplore?.is_approved ?? true ? Constants.Labels.approvedLable : Constants.Labels.notApprovedLable)
                            .foregroundColor(viewModel.detailedEventForExplore?.is_approved ?? true ? .green : .red)
                    }
                    .padding(.bottom, 20)
                    
                    VStack {

                        if let imageUrl = viewModel.detailedEventForExplore?.image, !imageUrl.isEmpty {
                            
                            AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    
                                    HStack {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                                            .frame(width: 200, height: 150)
                                            .scaleEffect(3)
                                            
                                        Spacer()
                                    }
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(height: 250)
                                        .scaledToFit()
                                        .cornerRadius(20)
                                case .failure(_):
                                   Rectangle()
                                        .frame(height: 250)
                                        .scaledToFit()
                                        .cornerRadius(20)
                                @unknown default:
                                    EmptyView()
                                }                            }
                        }
                    else {
                        Rectangle()
                            //.resizable()
                            .frame(height: 250)
                            .scaledToFit()
                            .cornerRadius(20)
                    }
                        
                        Text(viewModel.detailedEventForExplore?.description ?? "no description")
                            .multilineTextAlignment(.leading)
                            .padding(.vertical)
                       
                        Text(viewModel.getHashtagString())
                            .padding(.vertical, 8)
                            .multilineTextAlignment(.leading)
                        
                        
                        HStack {
                            Text("\(viewModel.detailedEventForExplore?.event_attendees_count ?? 0)")
                                .bold()
                                .font(.system(size: 17))
                            Text(Constants.Labels.attendees)
                            Spacer()
                            HStack {
                                if viewModel.detailedEventForExplore?.is_liked ?? true {
                                    
                                    Image(systemName: Constants.Images.heartFill)
                                        .foregroundColor(Constants.Colors.pinkColor)
                                        .font(.system(size: 17))
                                    Text(Constants.Labels.liked)
                                }
                                
                                else {
                                    Image(systemName: Constants.Images.heart)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 17))
                                    Text(Constants.Labels.notLiked)
                                }
                    
                            }
                            .onTapGesture {
                                print(viewModel.detailedEventForExplore!.is_liked)
                            }
                            Spacer()
                            HStack {
                                if viewModel.detailedEventForExplore?.is_favourite ?? true {
                                    
                                    Image(systemName: Constants.Images.starFill)
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 17))
                                    Text(Constants.Labels.favourite)
                                }
                                else {
                                    Image(systemName: Constants.Images.star)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 17))
                                    Text(Constants.Labels.notFavourite)
                                }
                                
                            }
                        }
                        .foregroundColor(.gray)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        HStack {
                            Text(Constants.Labels.eventTypes[(viewModel.detailedEventForExplore?.event_category_id ?? 2) - 1])
                            Spacer()
                        }
                        HStack {
                            Image(Constants.Images.location)
                            Text(viewModel.detailedEventForExplore?.location ?? "no location")
                            Spacer()
                            
                            Button {
                                viewModel.showMap.toggle()
                            } label: {
                                Image(systemName: Constants.Images.locationSquare)
                                    .font(.title)
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                            }
                            NavigationLink(destination: ContentView2(destination: (viewModel.detailedEventForExplore?.latitude ?? 0, viewModel.detailedEventForExplore?.longitude ?? 0)), isActive: $viewModel.showMap) {
                                Text("")
                            }
                        }
                        .padding(.vertical)
                    }
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
                            Text(viewModel.detailedEventForExplore?.start_date ?? "00")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: Constants.Images.clock)
                            Text(viewModel.detailedEventForExplore?.start_time ?? "00")
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
                            Text(viewModel.detailedEventForExplore?.end_date ?? "00")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: Constants.Images.clock)
                            Text(viewModel.detailedEventForExplore?.end_time ?? "00")
                            Spacer()
                        }
                    }
                    
                    Divider()
                    
                
                    HStack {

                            if let imageUrl = viewModel.detailedEventForExplore?.user_image, !imageUrl.isEmpty {
                                AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        HStack {
                                            Spacer()
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                                                .frame(width: 200, height: 150)
                                                .scaleEffect(3)
                                                
                                            Spacer()
                                        }
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    case .failure(_):
                                       Rectangle()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    @unknown default:
                                        EmptyView()
                                    }                            }
                            }
                        else {
                            Rectangle()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(viewModel.detailedEventForExplore?.user_name ?? "name")
                                    .font(.title3)
                                Text("\(viewModel.detailedEventForExplore?.follower_count ?? 0) followers")
                                    .foregroundColor(.gray)
                            }
                            
                            
                            Spacer()
                            
                            Button {
                                viewModel.followUser(id: viewModel.detailedEventForExplore!.user_id)
                                
                                viewModel.detailedEventForExplore!.is_followed.toggle()
                                print(viewModel.detailedEventForExplore!.is_followed)
                                if viewModel.detailedEventForExplore!.is_followed {
                                        viewModel.detailedEventForExplore!.follower_count += 1
                                    }
                                    else {
                                        viewModel.detailedEventForExplore!.follower_count -= 1
                                    }
                                
                            } label: {
                                if !(viewModel.detailedEventForExplore?.is_followed ?? true) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                            .frame(width: 80,height: 30)
                                            .cornerRadius(14)
                                        Text(Constants.Labels.follow)
                                            .foregroundColor(colorScheme == .light ? .white: .black)
                                            .padding()
                                    }
                                }
                                else {
                                    ZStack {
                                        
                                        Text(Constants.Labels.following)
                                            .foregroundColor(colorScheme == .light ? .black: .white)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 14)
                                                    .stroke(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), lineWidth: 2)
                                                    .frame(width: 80,height: 30)
                                            )
                                    }
                                }
                            }
                        }
                    .padding(.top, 20)
                
                    
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
        .onAppear {
            viewModel.showDetailedEventForExplore = true
            if eventType == .all {
                NetworkManager.shared.eventDetails(viewModel: viewModel, eventId: viewModel.events[indexOfEvent].id)
            }
            else if eventType == .created {
                NetworkManager.shared.eventDetails(viewModel: viewModel, eventId: viewModel.myEvents[indexOfEvent].id)
            }
            else if eventType == .favourite {
                NetworkManager.shared.eventDetails(viewModel: viewModel, eventId: viewModel.favouriteEvents[indexOfEvent].id)
            }
            else if eventType == .joined {
                NetworkManager.shared.eventDetails(viewModel: viewModel, eventId: viewModel.joinedEvents[indexOfEvent].id)
            }
        }
        .toolbar {
            if eventType == .created {
                Button {
                    viewModel.eventForEdit = viewModel.myEvents[indexOfEvent]
                    viewModel.actionType = .updateEvent
                    viewModel.createNewEventForEdit(event: viewModel.myEvents[indexOfEvent])
                    viewModel.showEditSheet.toggle()
                } label: {
                    Text("Edit")
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
