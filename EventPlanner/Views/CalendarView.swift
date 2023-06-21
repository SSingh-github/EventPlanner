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
        Group {
            if viewModel.joinedEvents.isEmpty == false {
                ScrollView{
                    CalendarStruct(interval: DateInterval(start: .distantPast, end: .distantFuture), viewModel: viewModel, dateSelected: $dateSelected, displayEvents: $displayEvents)
                        .accentColor(Constants.Colors.blueThemeColor)
                }
                .sheet(isPresented: $displayEvents) {
                    CalendarEventsList(viewModel: viewModel, dateSelected: $dateSelected)
                }
            }
            else {
                //calendar.badge.exclamationmark
                VStack {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.system(size: 100))
                    Text("upcoming events for you will be visible here")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
            }
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
