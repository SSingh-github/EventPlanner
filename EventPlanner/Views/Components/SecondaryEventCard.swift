//
//  SecondaryEventCard.swift
//  EventPlanner
//
//  Created by Chicmic on 13/06/23.
//

import SwiftUI

struct SecondaryEventCard: View {
    @Binding var event: Event
    var eventType: EventType
    @State var showEditEventSheet = false
    var body: some View {
        VStack {
            HStack {
                Text(event.title)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 4)
                .padding(.bottom, 3)
                Spacer()
                if eventType == .created {
                    Button {
                        print("edit event")
                        showEditEventSheet.toggle()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(Constants.Colors.blueThemeColor)
                            .font(.title3)
                    }
                    .sheet(isPresented: $showEditEventSheet) {
                        Text("Edit event view")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            HStack {
                Image(systemName: "calendar")
                Text(event.start_date)
                Spacer()
            }
            HStack {
                Image("Location")
                Text(event.location)
                Spacer()
                HStack {
                    if event.is_approved {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.subheadline)
                        Text("approved")
                            .font(.subheadline)
                    }
                    else {
                        Image(systemName: "hourglass")
                            .foregroundColor(.orange)
                            .font(.headline)
                        Text("pending  ")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

//struct SecondaryEventCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SecondaryEventCard()
//    }
//}
