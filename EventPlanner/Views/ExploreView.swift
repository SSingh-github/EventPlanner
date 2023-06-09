//
//  ExploreView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
   
    var body: some View {
        NavigationView {
            //if events array is empty, show some other view
            if viewModel.events.isEmpty == false {
                List {
                    ForEach(viewModel.events.indices, id: \.self) {index in
                       NavigationLink(destination: EventDetailsView(viewModel: viewModel)) {
                           EventCard(event: $viewModel.events[index], myEvent: false)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Constants.Labels.eventsForYou)
                .refreshable {
                    viewModel.getEventList()
                }
            }
            else {
                ScrollView {
                    Text("Events meant for you will be shown here")
                }
                .refreshable {
                    viewModel.getEventList()
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(viewModel: MainTabViewModel())
    }
}
