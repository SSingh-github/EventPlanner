//
//  FavouriteEvents.swift
//  EventPlanner
//
//  Created by Chicmic on 15/06/23.
//

import SwiftUI

struct FavouriteEvents: View {
    @ObservedObject var viewModel: MainTabViewModel
    var body: some View {
        List {
            ForEach(viewModel.favouriteEvents.indices, id:\.self) {index in
                NavigationLink {
                    EventDetailsView(viewModel: viewModel, indexOfEvent: index, eventType: .favourite)
                } label: {
                    SecondaryEventCard(event: $viewModel.favouriteEvents[index], eventType: .favourite)
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .onAppear {
            if viewModel.favouriteEvents.isEmpty {
                viewModel.getFavouriteEvents()
            }
        }
    }
}

struct FavouriteEvents_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEvents(viewModel: MainTabViewModel())
    }
}
