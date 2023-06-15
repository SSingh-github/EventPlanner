//
//  CreatedEvents.swift
//  EventPlanner
//
//  Created by Chicmic on 15/06/23.
//

import SwiftUI

struct CreatedEvents: View {
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        List {
            ForEach(viewModel.myEvents.indices, id:\.self) {index in
                NavigationLink {
                    EventDetailsView(viewModel: viewModel)
                } label: {
                    SecondaryEventCard(event: $viewModel.myEvents[index])
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
}

struct CreatedEvents_Previews: PreviewProvider {
    static var previews: some View {
        CreatedEvents(viewModel: MainTabViewModel())
    }
}
