//
//  CreatedEvents.swift
//  EventPlanner
//
//  Created by Chicmic on 15/06/23.
//

import SwiftUI

struct CreatedEvents: View {
    @ObservedObject var viewModel: MainTabViewModel
    @State var showDeleteAlert = false
    @State var index: Int = 0

    var body: some View {
        List {
            ForEach(viewModel.myEvents.indices, id:\.self) {index in
                NavigationLink {
                    EventDetailsView(viewModel: viewModel, indexOfEvent: index, eventType: .created)
                } label: {
                    SecondaryEventCard(event: $viewModel.myEvents[index], eventType: .created)
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
                index = indexPath.first!
                showDeleteAlert.toggle()
            }
            .actionSheet(isPresented: $showDeleteAlert) {
                ActionSheet(title: Text("Do you want to delete the event?"), message: nil, buttons: [
                    .destructive(Text("Delete").foregroundColor(.red), action: {
                        viewModel.deleteEvent(id: viewModel.myEvents[index].id)
                    }),
                    .cancel()
                ]
                )
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .onAppear {
            if viewModel.myEvents.isEmpty {
                viewModel.getMyEvents()
            }
        }
    }
}

struct CreatedEvents_Previews: PreviewProvider {
    static var previews: some View {
        CreatedEvents(viewModel: MainTabViewModel())
    }
}
