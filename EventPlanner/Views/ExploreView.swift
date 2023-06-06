//
//  ExploreView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10) {_ in
                    EventCard()
                }
            }
            .listStyle(.plain)
            .navigationTitle(Constants.Labels.eventsForYou)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
