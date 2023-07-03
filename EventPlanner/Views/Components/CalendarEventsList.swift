//
//  CalendarEventsList.swift
//  EventPlanner
//
//  Created by Chicmic on 16/06/23.
//

import SwiftUI

struct CalendarEventsList: View {
    @ObservedObject var viewModel: MainTabViewModel
    @Binding var dateSelected: DateComponents?

    var body: some View {
        List {
            ForEach(viewModel.joinedEvents.indices, id:\.self) {index in
                
                if viewModel.joinedEvents[index].start_date == Formatter.shared.formatSingleDate(date: dateSelected?.date ?? Date())  {
                    SecondaryEventCard(viewModel: viewModel, eventIndex: index, event: $viewModel.joinedEvents[index], eventType: .joined)
                        .listRowSeparator(.hidden)

                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

