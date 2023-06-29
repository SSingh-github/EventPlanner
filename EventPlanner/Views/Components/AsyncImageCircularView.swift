//
//  AsyncImageCircularView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct AsyncImageCircularView: View {
    
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                    .scaleEffect(3)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            case .failure(_):
                Image(systemName: Constants.Images.personFill)
                    .font(.system(size: 100))
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}
