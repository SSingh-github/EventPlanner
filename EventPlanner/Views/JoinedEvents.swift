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
                    ScrollView {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 100))
                            .padding(.top, 250)

                        Text("Events joined by you will be visible here")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .multilineTextAlignment(.center)
                        
                    }
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
    }
}

struct JoinedEvents_Previews: PreviewProvider {
    static var previews: some View {
        JoinedEvents(viewModel: MainTabViewModel())
    }
}
