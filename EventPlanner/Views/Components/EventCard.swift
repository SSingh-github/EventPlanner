//
//  EventCard.swift
//  EventPlanner
//
//  Created by Chicmic on 06/06/23.
//

import SwiftUI

struct EventCard: View {
    
    @Binding var event: Event
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let imageUrl = event.image, !imageUrl.isEmpty {
                    AsyncImageView(imageUrl: Constants.API.URLs.baseUrl + imageUrl, frameHeight: 150)
                }
                else {
                    Rectangle()
                        .frame(height: 150)
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                }
                VStack {
                    HStack {
                        Text(event.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                            .padding(.bottom, 3)
                        Spacer()
                            .foregroundColor(Constants.Colors.blueThemeColor)
                        
                        Button {
                            withAnimation{
                                event.is_favourite.toggle()
                                NetworkManager.shared.markEventAsFavourite(eventId: event.id)
                            }
                        } label: {
                            if event.is_favourite {
                                Image(systemName: Constants.Images.starFill)
                                    .foregroundColor(.orange)
                                    .frame(width: 45, height: 45)
                            }
                            else {
                                Image(systemName: Constants.Images.star)
                                    .foregroundColor(.gray)
                                    .bold()
                                    .frame(width: 45, height: 45)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button {
                            withAnimation{
                                NetworkManager.shared.likeTheEvent(eventId: event.id)
                                event.is_liked.toggle()
                                event.is_liked ? (event.like_count += 1) : (event.like_count -= 1)
                            }
                        } label: {
                            HStack{
                                if event.is_liked {
                                    Image(systemName: Constants.Images.heartFill)
                                        .foregroundColor(Constants.Colors.pinkColor)
                                }
                                else {
                                    Image(systemName:Constants.Images.heart)
                                        .foregroundColor(.gray)
                                        .bold()
                                }
                                Text("\(event.like_count)")
                                    .foregroundColor(.gray)
                                    .bold()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    HStack {
                        Text(event.location)
                            .foregroundColor(colorScheme == .dark ? .gray : .black)
                            .bold(colorScheme == .dark)
                        Spacer()
                    }
                }
                .padding([.bottom, .trailing])
            }
            .background(colorScheme == .dark ? .black : .white)
            .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(event.start_date.suffix(2))
                    .font(.largeTitle)
                Text(Constants.Labels.months[String(event.start_date[Formatter.shared.getMonthIndexRange(date: event.start_date)])]!)
                    .font(.title2)
            }
            .padding(.leading)
            .padding(.bottom, 47)
        }
    }
}

