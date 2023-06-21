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
            Image("eventplanner")
                .resizable()
                .frame(height: 300)
            Text("Event Planner")
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
