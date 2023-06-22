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
                        // Show the image using the URL
                        AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder view while the image is being loaded
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                                        .frame(width: 200, height: 150)
                                        .scaleEffect(3)
                                        
                                    Spacer()
                                }
                            case .success(let image):
                                // Display the loaded image
                                image
                                    .resizable()
                                    .frame(height: 150)
                                    .scaledToFit()
                                    .cornerRadius(20)
                            case .failure(_):
                                // Show an error placeholder if the image fails to load
                               Rectangle()
                                    .frame(height: 150)
                                    .foregroundColor(.gray)
                                    .cornerRadius(20)
                            @unknown default:
                                // Handle any future cases if needed
                                EmptyView()
                            }                            }
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
                                if event.is_liked {
                                    event.like_count += 1
                                }
                                else {
                                    event.like_count -= 1
                                }
                            }
                        } label: {
                            HStack{
                                if event.is_liked {
                                    Image(systemName: Constants.Images.starFill)
                                        .foregroundColor(Constants.Colors.pinkColor)
                                }
                                else {
                                    Image(systemName:Constants.Images.star)
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

