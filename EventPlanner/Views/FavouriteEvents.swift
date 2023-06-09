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
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)

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
                    PlaceholderView(imageName: Constants.Images.starFill, lable: Constants.Labels.favouriteEvents)
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
        .alert(isPresented: $viewModel.showFavEventsAlert) {
            Alert(
                title: Text(""), message: Text(viewModel.alertMessage),
                dismissButton: .default(Text(Constants.Labels.ok)
                    .foregroundColor(Constants.Colors.blueThemeColor)))
        }
    }
}

struct FavouriteEvents_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEvents(viewModel: MainTabViewModel())
    }
}
