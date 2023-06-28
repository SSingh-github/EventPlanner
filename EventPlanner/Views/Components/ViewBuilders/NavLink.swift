//
//  NavLink.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI


struct NavLink<Content: View> : View {
    
    let buttonDisabled: Bool
    let content: () -> Content
    
    var body: some View {
        
        NavigationLink(destination: content) {
            ZStack {
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(buttonDisabled ? .gray : Constants.Colors.blueThemeColor)
                    .cornerRadius(10)
                Text( Constants.Labels.Continue)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .padding(.vertical)
        }
        .disabled(buttonDisabled)
    }
}
