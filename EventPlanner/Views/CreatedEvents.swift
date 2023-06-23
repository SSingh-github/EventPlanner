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
        ZStack {
            Group {
                if viewModel.myEvents.isEmpty == false {
                    List {
                        ForEach(viewModel.myEvents.indices, id:\.self) {index in
                            NavigationLink {
                                EventDetailsView(viewModel: viewModel, indexOfEvent: index, eventType: .created)
                            } label: {
                                SecondaryEventCard(viewModel: viewModel, eventIndex: index, event: $viewModel.myEvents[index], eventType: .created)
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 20)
                                    .background(.secondary)
                                    .foregroundColor(.clear)
                                    .padding(
                                        EdgeInsets(
                                            top: 2,
                                            leading: 10,
                                            bottom: 2,
                                            trailing: 10
                                        )
                                    )
                            )
                            .listRowSeparator(.hidden)
                        }
                        .onDelete { indexPath in
                            viewModel.index = indexPath.first!
                            viewModel.showDeleteAlert.toggle()
                        }
                        .actionSheet(isPresented: $viewModel.showDeleteAlert) {
                            ActionSheet(title: Text(Constants.Labels.Questions.deleteEvent), message: nil, buttons: [
                                .destructive(Text(Constants.Labels.delete).foregroundColor(.red), action: {
                                    viewModel.deleteEvent(id: viewModel.myEvents[viewModel.index].id)
                                }),
                                .cancel()
                            ]
                            )
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                    .listStyle(PlainListStyle())
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("")
                    .refreshable {
                        viewModel.getMyEvents()
                    }
                    
                }
               else {
                    ScrollView {
                        Image(systemName: Constants.Images.rectanglePencil)
                            .font(.system(size: 100))
                            .padding(.top, 250)

                        Text(Constants.Labels.createdEvents)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("")
                    .refreshable {
                        viewModel.getMyEvents()
                    }
                }
            }
            .onAppear {
                if viewModel.myEvents.isEmpty {
                    viewModel.getMyEvents()
                }
            }
            if viewModel.createdEventsLoading {
                LoadingView()
            }
        }
        .alert(isPresented: $viewModel.showMyEventsAlert) {
            Alert(
                title: Text(""), message: Text(viewModel.alertMessage),
                dismissButton: .default(Text(Constants.Labels.ok)
                    .foregroundColor(Constants.Colors.blueThemeColor)))
        }
    }
}

struct CreatedEvents_Previews: PreviewProvider {
    static var previews: some View {
        CreatedEvents(viewModel: MainTabViewModel())
    }
}
