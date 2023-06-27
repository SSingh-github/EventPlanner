//
//  UpperEventDetailsView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct UpperEventDetailsView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack {

            if let imageUrl = viewModel.detailedEventForExplore?.image, !imageUrl.isEmpty {
                
                AsyncImageView(imageUrl: Constants.API.URLs.baseUrl + imageUrl, frameHeight: 250)
            }
        else {
            Rectangle()
                //.resizable()
                .frame(height: 250)
                .scaledToFit()
                .cornerRadius(20)
        }
            
            Text(viewModel.detailedEventForExplore?.description ?? Constants.Labels.noDescription)
                .multilineTextAlignment(.leading)
                .padding(.vertical)
           
            Text(viewModel.getHashtagString())
                .padding(.vertical, 8)
                .multilineTextAlignment(.leading)
            
            
            HStack {
                Text("\(viewModel.detailedEventForExplore?.event_attendees_count ?? 0)")
                    .bold()
                    .font(.system(size: 17))
                Text(Constants.Labels.attendees)
                Spacer()
                HStack {
                    if viewModel.detailedEventForExplore?.is_liked ?? true {
                        
                        Image(systemName: Constants.Images.heartFill)
                            .foregroundColor(Constants.Colors.pinkColor)
                            .font(.system(size: 17))
                        Text(Constants.Labels.liked)
                    }
                    
                    else {
                        Image(systemName: Constants.Images.heart)
                            .foregroundColor(.gray)
                            .font(.system(size: 17))
                        Text(Constants.Labels.notLiked)
                    }
        
                }
                .onTapGesture {
                    print(viewModel.detailedEventForExplore!.is_liked)
                }
                Spacer()
                HStack {
                    if viewModel.detailedEventForExplore?.is_favourite ?? true {
                        
                        Image(systemName: Constants.Images.starFill)
                            .foregroundColor(.yellow)
                            .font(.system(size: 17))
                        Text(Constants.Labels.favourite)
                    }
                    else {
                        Image(systemName: Constants.Images.star)
                            .foregroundColor(.gray)
                            .font(.system(size: 17))
                        Text(Constants.Labels.notFavourite)
                    }
                    
                }
            }
            .foregroundColor(.gray)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.vertical)
            HStack {
                Text(Constants.Labels.eventTypes[(viewModel.detailedEventForExplore?.event_category_id ?? 2) - 1])
                Spacer()
            }
            HStack {
                Image(Constants.Images.location)
                Text(viewModel.detailedEventForExplore?.location ?? Constants.Labels.noLocation)
                Spacer()
                
                Button {
                    viewModel.showMap.toggle()
                } label: {
                    Image(systemName: Constants.Images.locationSquare)
                        .font(.title)
                        .foregroundColor(Constants.Colors.blueThemeColor)
                }
                NavigationLink(destination: ContentView2(destination: (viewModel.detailedEventForExplore?.latitude ?? 0, viewModel.detailedEventForExplore?.longitude ?? 0)), isActive: $viewModel.showMap) {
                    Text("")
                }
            }
            .padding(.vertical)
        }

    }
}
