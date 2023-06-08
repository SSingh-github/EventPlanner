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
    @State var liked = false
    @State var markedFavorite = false
    
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
                            case .failure(_):
                                // Show an error placeholder if the image fails to load
                               Rectangle()
                                    .frame(height: 150)
                                    .foregroundColor(.gray)
                            @unknown default:
                                // Handle any future cases if needed
                                EmptyView()
                            }                            }
                    }
                else {
                    Rectangle()
                         .frame(height: 150)
                         .foregroundColor(.gray)
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
                                markedFavorite.toggle()
                            }
                        } label: {
                            if markedFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                    .frame(width: 45, height: 45)
                            }
                            else {
                                Image(systemName: "star")
                                    .frame(width: 45, height: 45)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button {
                            withAnimation{
                                liked = !liked
                            }
                        } label: {
                            if liked {
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(Constants.Colors.blueThemeColor)
                                    .frame(width: 45, height: 45)
                            }
                            else {
                                Image(systemName: "hand.thumbsup")
                                    .frame(width: 45, height: 45)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        

                    }
                    HStack {
                        Text(event.location)
                        
                        Spacer()
                    }
                }
                .padding([.bottom, .horizontal])
            }
            .background(colorScheme == .dark ? .black : .white)
            .cornerRadius(20)
            .shadow(color: colorScheme == .dark ? .white : .black, radius: 5)
            
            VStack(alignment: .leading) {
                Text(event.start_date.suffix(2))
                    .font(.largeTitle)
                Text(Constants.Labels.months[String(event.start_date[Formatter.shared.getMonthIndexRange(date: event.start_date)])]!)
                    .font(.title2)
            }
            .padding(.leading)
        }
    }
}

//struct EventCard_Previews: PreviewProvider {
//    static var previews: some View {
//        EventCard()
//    }
//}
