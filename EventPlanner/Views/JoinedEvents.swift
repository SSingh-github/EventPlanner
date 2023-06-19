//
//  JoinedEvents.swift
//  EventPlanner
//
//  Created by Chicmic on 15/06/23.
//

import SwiftUI

struct JoinedEvents: View {
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        List {
            ForEach(viewModel.joinedEvents.indices, id:\.self) {index in
                NavigationLink {
                    EventDetailsView(viewModel: viewModel, indexOfEvent: index, eventType: .joined)
                } label: {
                    SecondaryEventCard(event: $viewModel.joinedEvents[index], eventType: .joined)
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .onAppear {
            if viewModel.joinedEvents.isEmpty {
                viewModel.getJoinedEvents()
            }
        }
    }
}

struct JoinedEvents_Previews: PreviewProvider {
    static var previews: some View {
        JoinedEvents(viewModel: MainTabViewModel())
    }
}
