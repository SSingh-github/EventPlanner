//
//  SecondaryEventCard.swift
//  EventPlanner
//
//  Created by Chicmic on 13/06/23.
//

import SwiftUI

struct SecondaryEventCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("Sports Event")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 4)
                .padding(.bottom, 3)
                Spacer()
            }
            HStack {
                Image(systemName: "calendar")
                Text("24, June 2023")
                Spacer()
            }
            HStack {
                Image("Location")
                Text("mohali, sector 74 phase 8b")
                Spacer()
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.subheadline)
                    Text("approved")
                        .font(.subheadline)
                }
            }
            
           
        }
        
        //.background(.red)
        //.cornerRadius(20)
        
    }
}

struct SecondaryEventCard_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryEventCard()
    }
}
