//
//  LoadingView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                .scaleEffect(2)
                Text(Constants.Labels.loading)
                    .padding(.top, 40)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
