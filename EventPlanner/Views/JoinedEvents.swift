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
        ZStack {
            Group {
                if viewModel.joinedEvents.isEmpty == false {
                    List {
                        ForEach(viewModel.joinedEvents.indices, id:\.self) {index in
                            NavigationLink {
                                EventDetailsView(viewModel: viewModel, indexOfEvent: index, eventType: .joined)
                            } label: {
                                SecondaryEventCard(viewModel: viewModel, eventIndex: index,event: $viewModel.joinedEvents[index], eventType: .joined)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)

                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("")
                    .refreshable {
                        viewModel.getJoinedEvents()
                    }
                    
                }
                else {
                    PlaceholderView(imageName: Constants.Images.person2, lable: Constants.Labels.joinedEvents)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("")
                    .refreshable {
                        viewModel.getJoinedEvents()
                    }
                }
            }
            .onAppear {
                if viewModel.joinedEvents.isEmpty {
                    viewModel.getJoinedEvents()
                }
        }
            if viewModel.joinedEventsLoading {
                LoadingView()
            }
        }
        .alert(isPresented: $viewModel.showJoinedEventsAlert) {
            Alert(
                title: Text(""), message: Text(viewModel.alertMessage),
                dismissButton: .default(Text(Constants.Labels.ok)
                    .foregroundColor(Constants.Colors.blueThemeColor)))
        }
    }
}

struct JoinedEvents_Previews: PreviewProvider {
    static var previews: some View {
        JoinedEvents(viewModel: MainTabViewModel())
    }
}
