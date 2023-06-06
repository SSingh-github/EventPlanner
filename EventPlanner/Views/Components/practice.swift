//
//  practice.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//


import SwiftUI


struct ContentView2: View {
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Label {
                    Text("  use current location")
                        .font(.callout)
                } icon: {
                    Image(systemName: "location.north.circle.fill")
                }
                .foregroundColor(.green)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            VStack(alignment: .center, spacing: 20) {
                Image(systemName: "magnifyingglass")
                    .font(.largeTitle)
                Text("Your Search results will appear here")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
