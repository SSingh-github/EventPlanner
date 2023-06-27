//
//  PlaceholderView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import SwiftUI

struct PlaceholderView: View {
    
    let imageName: String
    let lable: String
    
    var body: some View {
        ScrollView {
            Image(systemName: imageName)
                .font(.system(size: 100))
                .padding(.top, 250)
            Text(lable)
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}

