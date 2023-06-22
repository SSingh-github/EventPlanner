//
//  SplashScreenView.swift
//  EventPlanner
//
//  Created by Chicmic on 14/06/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(Constants.Images.eventPlanner)
                .resizable()
                .frame(height: 300)
            Text(Constants.Labels.eventPlanner)
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
