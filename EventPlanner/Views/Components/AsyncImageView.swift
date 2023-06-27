//
//  AsyncImageView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct AsyncImageView: View {
    
    let imageUrl: String
    let frameHeight: CGFloat
    
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
                    .frame(height: frameHeight)
                    .scaledToFit()
                    .cornerRadius(20)
            case .failure(_):
                Rectangle()
                    .frame(height: frameHeight)
                    .foregroundColor(.gray)
                    .cornerRadius(20)
            @unknown default:
                EmptyView()
            }
        }
    }
}
