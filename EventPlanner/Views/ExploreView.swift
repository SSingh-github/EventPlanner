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
           
            if viewModel.events.isEmpty == false {
                List {
                    ForEach(viewModel.events.indices, id: \.self) {index in
                        NavigationLink(destination: EventDetailsView(viewModel: viewModel, indexOfEvent: index, eventType: .all)) {
                           EventCard(event: $viewModel.events[index])
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Constants.Labels.eventsForYou)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showFilterView.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.primary)
                                .font(.title3)
                        }
                        .sheet(isPresented: $viewModel.showFilterView) {
                            FilterView(viewModel: viewModel)
                        }
                    }
                }
                .refreshable {
                    viewModel.getEventList()
                }
            }
            else {
                VStack {
                    Image(systemName: "list.bullet.clipboard.fill")
                        .font(.system(size: 100))
                    Text("Events near you will be visible here")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .multilineTextAlignment(.center)
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
