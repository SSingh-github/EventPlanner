//
//  CalendarView.swift
//  EventPlanner
//
//  Created by Chicmic on 13/06/23.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    @State private var dateSelected: DateComponents?
    @State private var displayEvents = false
    
    var body: some View {
        ScrollView{
            CalendarStruct(interval: DateInterval(start: .distantPast, end: .distantFuture), viewModel: viewModel, dateSelected: $dateSelected, displayEvents: $displayEvents)
                .accentColor(Constants.Colors.blueThemeColor)
        }
        .sheet(isPresented: $displayEvents) {
            CalendarEventsList(viewModel: viewModel, dateSelected: $dateSelected)
        }
        .onAppear {
            if viewModel.joinedEvents.isEmpty {
                viewModel.getJoinedEvents()
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: MainTabViewModel())
    }
}
