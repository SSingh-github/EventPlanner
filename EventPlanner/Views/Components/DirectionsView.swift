//
//  DirectionsView.swift
//  EventPlanner
//
//  Created by Chicmic on 09/06/23.
//

import SwiftUI

struct DirectionsView: View {
    
    @Binding var directions: [String]
    
    var body: some View {
        VStack {
            Text("Directions")
                .font(.title)
                .fontWeight(.semibold)
                .padding(40)
            
            List {
                ForEach(directions.indices, id: \.self) {index in
                    Text(directions[index])
                        .padding()
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

//struct DirectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsView()
//    }
//}
