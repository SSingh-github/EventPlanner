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
                    EventDetailsView(viewModel: viewModel)
                } label: {
                    SecondaryEventCard(event: $viewModel.myEvents[index])
                }
            }
            .onDelete { indexPath in
                index = indexPath.first!
                showDeleteAlert.toggle()
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(title: Text(""),message: Text(Constants.Labels.Questions.delete), primaryButton: .cancel(Text(Constants.Labels.Alerts.cancel)), secondaryButton: .default(Text(Constants.Labels.ok)) {
                    //make the delete api call here, and reload the my events array showing the loading view
                    viewModel.deleteEvent(id: viewModel.myEvents[index].id)

                })
            }

        }
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
}

struct CreatedEvents_Previews: PreviewProvider {
    static var previews: some View {
        CreatedEvents(viewModel: MainTabViewModel())
    }
}
