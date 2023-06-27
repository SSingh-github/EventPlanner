//
//  practice.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//


import SwiftUI
import MapKit


struct ContentView2: View {
    
  
    @State var directions: [String] = []
    @State var showDirectionsSheet = false
    @State var destination : (Double, Double) = (30.378180, 76.776695)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            MapView(directions: $directions, destination: $destination)
            
            Button {
                showDirectionsSheet.toggle()
            } label: {
                Image(systemName: Constants.Images.directions)
                    .font(.largeTitle)
                    .foregroundColor(Constants.Colors.blueThemeColor)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 10)
                    }
            }
            .disabled(directions.isEmpty)
            .padding(.bottom, 150)
            .padding(.trailing)
           
        }
        .sheet(isPresented: $showDirectionsSheet, content: {DirectionsView(directions: $directions)})
        .ignoresSafeArea()
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}


