//
//  EventDetailsView.swift
//  EventPlanner
//
//  Created by Chicmic on 08/06/23.

// person.fill.badge.plus symbol to join the event


import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @State var showMap = false
    @State var navigate = false
    @Environment(\.colorScheme) var colorScheme
    var indexOfEvent: Int = 0
    var eventType: EventType = .all
    //id of current event = viewModel.events[indexOfEvent].id

    var body: some View {
    
        ZStack {
            ScrollView(showsIndicators: false) {
                    VStack {
                        
                        Text(viewModel.detailedEventForExplore?.title ?? "no title")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4)
                        Text(viewModel.detailedEventForExplore?.is_approved ?? true ? "(Approved)" : "(Not Approved)")
                            .foregroundColor(viewModel.detailedEventForExplore?.is_approved ?? true ? .green : .red)
                    }
                    .padding(.bottom, 20)
                    
                    VStack {

                        if let imageUrl = viewModel.detailedEventForExplore?.image, !imageUrl.isEmpty {
                            // Show the image using the URL
                            AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    // Placeholder view while the image is being loaded
                                    HStack {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                                            .frame(width: 200, height: 150)
                                            .scaleEffect(3)
                                            
                                        Spacer()
                                    }
                                case .success(let image):
                                    // Display the loaded image
                                    image
                                        .resizable()
                                        .frame(height: 250)
                                        .scaledToFit()
                                        .cornerRadius(20)
                                case .failure(_):
                                    // Show an error placeholder if the image fails to load
                                   Rectangle()
                                        //.resizable()
                                        .frame(height: 250)
                                        .scaledToFit()
                                        .cornerRadius(20)
                                @unknown default:
                                    // Handle any future cases if needed
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
                           // Spacer()
                            Text("\(viewModel.detailedEventForExplore?.event_attendees_count ?? 0)")
                                .bold()
                                .font(.system(size: 17))
                            Text("attendees ")
                            Spacer()
                            HStack {
                                if viewModel.detailedEventForExplore?.is_liked ?? true {
                                    
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Constants.Colors.pinkColor)
                                        .font(.system(size: 17))
                                    Text("liked")
                                }
                                
                                else {
                                    Image(systemName: "heart")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 17))
                                    Text("Not liked")
                                }
                    
                            }
                            .onTapGesture {
                                print(viewModel.detailedEventForExplore!.is_liked)
                            }
                            Spacer()
                            HStack {
                                if viewModel.detailedEventForExplore?.is_favourite ?? true {
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 17))
                                    Text("favourite")
                                }
                                else {
                                    Image(systemName: "star")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 17))
                                    Text("Not favourite")
                                }
                                
                            }
                            //Spacer()
                        }
                        .foregroundColor(.gray)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        //Divider()
                        HStack {
                            Text(Constants.Labels.eventTypes[(viewModel.detailedEventForExplore?.event_category_id ?? 2) - 1])
                                //.font(.title3)
                            Spacer()
                        }
                        //Divider()
                        HStack {
                            Image("Location")
                            Text(viewModel.detailedEventForExplore?.location ?? "no location")
                                //.font(.title3)
                            Spacer()
                            
                            Button {
                                print("move to map view")
                                showMap.toggle()
                            } label: {
                                Image(systemName: "location.square.fill")
                                    .font(.title)
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                            }
                            NavigationLink(destination: ContentView2(destination: (viewModel.detailedEventForExplore?.latitude ?? 0, viewModel.detailedEventForExplore?.longitude ?? 0)), isActive: $showMap) {
                                Text("")
                            }
                        }
                        .padding(.vertical)
                        //Divider()
                    }
                    HStack {
                        Text("Commencement")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(viewModel.detailedEventForExplore?.start_date ?? "00")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: "clock")
                            Text(viewModel.detailedEventForExplore?.start_time ?? "00")
                            Spacer()
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Culmination")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(viewModel.detailedEventForExplore?.end_date ?? "00")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: "clock")
                            Text(viewModel.detailedEventForExplore?.end_time ?? "00")
                            Spacer()
                        }
                    }
                    
                    Divider()
                    
                    HStack {

                        if let imageUrl = viewModel.detailedEventForExplore?.user_image, !imageUrl.isEmpty {
                            // Show the image using the URL
                            AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    // Placeholder view while the image is being loaded
                                    HStack {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                                            .frame(width: 200, height: 150)
                                            .scaleEffect(3)
                                            
                                        Spacer()
                                    }
                                case .success(let image):
                                    // Display the loaded image
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                case .failure(_):
                                    // Show an error placeholder if the image fails to load
                                   Rectangle()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                @unknown default:
                                    // Handle any future cases if needed
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
                        //.padding()
                        //.background(.white)
                        
                        Spacer()
                        
                        Button {
                            print("follow the user")
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
                                    Text("follow")
                                        .foregroundColor(colorScheme == .light ? .white: .black)
                                        .padding()
                                }
                            }
                            else {
                                ZStack {
                                    
                                    Text("following")
                                        .foregroundColor(colorScheme == .light ? .black: .white)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                                                .frame(width: 80,height: 30)
                                        )
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    Button {
                        print("join the event")
                        viewModel.joinEvent(id: viewModel.events[indexOfEvent].id)
                        viewModel.detailedEventForExplore!.is_joined.toggle()
                        if viewModel.detailedEventForExplore!.is_joined {
                            viewModel.detailedEventForExplore!.event_attendees_count += 1
                        }
                        else {
                            viewModel.detailedEventForExplore!.event_attendees_count -= 1
                        }
                    } label: {
                        if !(viewModel.detailedEventForExplore?.is_joined ?? true) {
                            ZStack {
                                Rectangle()
                                    .frame(height: 60)
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                                    .cornerRadius(10)
                                Text("Join event")
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
                                Text("Joined")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
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
                    print(viewModel.eventForEdit!)
                    //create a function in viewmodel that takes the event for edit and creates a new event of type newevent and call it here
                    viewModel.createNewEventForEdit(event: viewModel.myEvents[indexOfEvent])
                    viewModel.showEditSheet.toggle()
                } label: {
                    Text("Edit")
                }.sheet(isPresented: $viewModel.showEditSheet, onDismiss: {
                    viewModel.actionType = .createEvent
                }) {
                    //EditEventView(viewModel: viewModel, eventIndex: indexOfEvent)
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
