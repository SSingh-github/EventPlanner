//
//  AsyncImageProfileView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct AsyncImageProfileView: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                        .frame(width: 200, height: 150)
                        .scaleEffect(3)
                    
                    Spacer()
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
            case .failure(_):
                Rectangle()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
            @unknown default:
                EmptyView()
            }
        }
    }
}
