//
//  EventBarView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct EventBarView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            
            //MARK: USER PROFILE IMAGE
            if let imageUrl = viewModel.detailedEventForExplore?.user_image, !imageUrl.isEmpty {
                AsyncImageProfileView(imageUrl: Constants.API.URLs.baseUrl + imageUrl)
            }
            else {
                Rectangle()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.detailedEventForExplore?.user_name ?? "")
                    .font(.title3)
                Text(Constants.Labels.followers + "\(viewModel.detailedEventForExplore?.follower_count ?? 0) ")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            //MARK: FOLLOW USER BUTTON
            Button {
                viewModel.followUser(id: viewModel.detailedEventForExplore!.user_id)
                
                viewModel.detailedEventForExplore!.is_followed.toggle()
                print(viewModel.detailedEventForExplore!.is_followed)
                if viewModel.detailedEventForExplore!.is_followed {
                    viewModel.detailedEventForExplore!.follower_count += 1
                }
                else {
                    viewModel.detailedEventForExplore!.follower_count -= 1
                }
                
            } label: {
                if !(viewModel.detailedEventForExplore?.is_followed ?? true) {
                    ZStack {
                        
                        Text(Constants.Labels.follow)
                            .foregroundColor(colorScheme == .light ? .black: .white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), lineWidth: 2)
                                    .frame(width: 80,height: 30)
                            )
                    }
                }
                else {
                    ZStack {
                        
                        Text(Constants.Labels.following)
                            .foregroundColor(colorScheme == .light ? .black: .white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), lineWidth: 2)
                                    .frame(width: 80,height: 30)
                            )
                    }
                }
            }
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

