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
        ZStack {
            Group {
                if viewModel.favouriteEvents.isEmpty == false {
                    List {
                        ForEach(viewModel.favouriteEvents.indices, id:\.self) {index in
                            NavigationLink {
                                EventDetailsView(viewModel: viewModel, indexOfEvent: index, eventType: .favourite)
                            } label: {
                                SecondaryEventCard(viewModel: viewModel, eventIndex: index, event: $viewModel.favouriteEvents[index], eventType: .favourite)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("")
                    .refreshable {
                        viewModel.getFavouriteEvents()
                    }
                    
                }
                else {
                    ScrollView {
                        Image(systemName: "star.fill")
                            .font(.system(size: 100))
                            .padding(.top, 250)

                        Text("Events marked favourite by you will be visible here")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("")
                    .refreshable {
                        viewModel.getFavouriteEvents()
                    }
                }
            }
            .onAppear {
                if viewModel.favouriteEvents.isEmpty {
                    viewModel.getFavouriteEvents()
                }
        }
            if viewModel.favouriteEventsLoading {
                LoadingView()
            }
        }
    }
}

struct FavouriteEvents_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEvents(viewModel: MainTabViewModel())
    }
}
