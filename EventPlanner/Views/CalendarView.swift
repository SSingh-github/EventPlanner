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
                    Text(Constants.Labels.eventCalendar)
                        .font(.title)
                        .bold()
                        .padding(.top)
                    CalendarStruct(interval: DateInterval(start: .distantPast, end: .distantFuture), viewModel: viewModel, dateSelected: $dateSelected, displayEvents: $displayEvents)
                        .accentColor(Constants.Colors.blueThemeColor)
                        .padding()
                        .background(.secondary.opacity(0.2))
                        .cornerRadius(20)
                }
                .sheet(isPresented: $displayEvents) {
                    CalendarEventsList(viewModel: viewModel, dateSelected: $dateSelected)
                }
                .padding(.horizontal)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
            }
            else {
                ScrollView {
                    Image(systemName: Constants.Images.calendarExclamation)
                        .font(.system(size: 100))
                        .padding(.top, 250)

                    Text(Constants.Labels.upcomingEvents)
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
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: MainTabViewModel())
    }
}
