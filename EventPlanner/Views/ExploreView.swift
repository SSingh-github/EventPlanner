//
//  ExploreView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//
/*
 filtering api fixing, checkboxes in filter view for selective filtering, showing details of the event in detailsview, fixing the like and favrourite events, modifying the annotation in map view
 */
import SwiftUI

struct ExploreView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
   
    var body: some View {
        NavigationView {
           
            if viewModel.events.isEmpty == false {
                List {
                    ForEach(viewModel.events.indices, id: \.self) {index in
                       NavigationLink(destination: EventDetailsView(viewModel: viewModel, indexOfEvent: index)) {
                           EventCard(event: $viewModel.events[index], myEvent: false)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Constants.Labels.eventsForYou)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Filter") {
                            viewModel.showFilterView.toggle()
                        }
                        .foregroundColor(Constants.Colors.blueThemeColor)
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
