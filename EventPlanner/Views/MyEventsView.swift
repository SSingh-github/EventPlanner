//
//  MyEventsView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct MyEventsView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {

        if viewModel.guestLogin {
            LoginSignupView()
        }
        else if viewModel.userLogin {
            
            NavigationView {
                //if events array is empty, show some other view
                if viewModel.myEvents.isEmpty == false {
                    List {
                        ForEach(viewModel.myEvents.indices, id: \.self) {index in
                            NavigationLink(destination: EventDetailsView(viewModel: viewModel)) {
                                EventCard(event: $viewModel.myEvents[index], myEvent: true)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("My events")
                    .refreshable {
                        viewModel.getMyEvents()
                    }
                }
                else {
                    ScrollView {
                        Text("Events posted by you will be shown here")
                    }
                    .refreshable {
                        viewModel.getMyEvents()
                    }
                }
            }
        }
    }
}

struct MyEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MyEventsView(viewModel: MainTabViewModel())
    }
}
