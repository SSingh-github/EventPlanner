//
//  EventCard.swift
//  EventPlanner
//
//  Created by Chicmic on 06/06/23.
//

import SwiftUI

struct EventCard: View {
    
    @State var isStarred = false
    @State var isActive = true
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    Image("background")
                        
                        .resizable()
                        .frame(height: 200)
                        .scaledToFit()
                        //.clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                VStack {
                    HStack {
                        Text("Birthday Party")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.vertical)
                        
                        Spacer()
                        
                        Image(systemName:Constants.Images.circleFill)
                            .foregroundColor(isActive ? .green : .red)
                            .font(.system(size: 15))
                    }
                    
                    
                    HStack {
                        Image(systemName: Constants.Images.calendar)
                            .font(.title3)
                        Text("14, June to 16, June")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    HStack {
                        Image("Location")
                            .font(.title)
                            .tint(.primary)
                        Text("Mohali, phase 5")
                            .fontWeight(.semibold)
                        
                        
                        Spacer()
                        Button(action: {
                            isStarred.toggle()
                        }) {
                            Image(systemName: isStarred ? "star.fill" : "star")
                                .foregroundColor(isStarred ? .yellow : .gray)
                                .font(.system(size: 24))
                        }
                    }
                }
                .padding([.bottom, .horizontal])
            }
            
            .cornerRadius(10)
           
            .background(.tertiary.opacity(0.6))
            .cornerRadius(20)
            //.padding()
        }
        
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard()
    }
}
