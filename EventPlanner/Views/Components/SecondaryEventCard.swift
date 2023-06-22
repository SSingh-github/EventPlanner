//
//  SecondaryEventCard.swift
//  EventPlanner
//
//  Created by Chicmic on 13/06/23.
//

import SwiftUI

struct SecondaryEventCard: View {
    @ObservedObject var viewModel: MainTabViewModel
    var eventIndex: Int
    @Binding var event: Event
    var eventType: EventType
    var body: some View {
        VStack {
            HStack {
                Text(event.title)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 4)
                .padding(.bottom, 3)
                Spacer()
            }
            
            HStack {
                Image(systemName: Constants.Images.calendar)
                Text(event.start_date)
                Spacer()
            }
            HStack {
                Image(Constants.Images.location)
                Text(event.location)
                Spacer()
                HStack {
                    if event.is_approved {
                        Image(systemName: Constants.Images.checkMark)
                            .foregroundColor(.green)
                            .font(.subheadline)
                        Text(Constants.Labels.approved)
                            .font(.subheadline)
                    }
                    else {
                        Image(systemName: Constants.Images.hourGlass)
                            .foregroundColor(.orange)
                            .font(.headline)
                        Text(Constants.Labels.pending)
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

