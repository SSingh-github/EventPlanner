//
//  MyEventsView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct MyEventsView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var options = ["Favourite events", "Joined Events", "Created Events", "Upcoming"]
    
    var body: some View {
        
        NavigationView {
            List {  

                ForEach(options.indices, id:\.self) { index in
                    NavigationLink {
                        if index == 0 {
                            FavouriteEvents(viewModel: viewModel)
                        }
                        else if index == 1 {
                            JoinedEvents(viewModel: viewModel)
                        }
                        else if index == 2 {
                            CreatedEvents(viewModel: viewModel)
                        }
                        else {
                            CalendarView(viewModel: viewModel)
                        }
                    } label: {
                        HStack {
                            Text(options[index])
                        }
                        .frame(height: 50)
                        .font(.title3)
                        .fontWeight(.semibold)
                    }
                }
            }
            //.listStyle(PlainListStyle())
            .navigationTitle("My Events")
        }

//        if viewModel.guestLogin {
//            LoginSignupView()
//        }
//        else if viewModel.userLogin {
//
//            NavigationView {
//                //if events array is empty, show some other view
//                if viewModel.myEvents.isEmpty == false {
//                    List {
//                        ForEach(viewModel.myEvents.indices, id: \.self) {index in
//                            NavigationLink(destination: EventDetailsView(viewModel: viewModel)) {
//                                EventCard(event: $viewModel.myEvents[index], myEvent: true)
//                            }
//                        }
//                    }
//                    .listStyle(.plain)
//                    .navigationTitle("My events")
//                    .refreshable {
//                        viewModel.getMyEvents()
//                    }
//                }
//                else {
//                    ScrollView {
//                        Text("Events posted by you will be shown here")
//                    }
//                    .refreshable {
//                        viewModel.getMyEvents()
//                    }
//                }
//            }
//        }
    }
}

struct MyEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MyEventsView(viewModel: MainTabViewModel())
    }
}
