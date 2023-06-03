//
//  AddNewEventView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI

struct AddNewEventView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("add new event")
                NavigationLink(destination: DateAndTimeView()) {
                    Text("continue")
                }
            }
            .navigationTitle("Create Event")
        }
    }
}

struct AddNewEventView_Previews: PreviewProvider {
    static var previews: some View {
       
            AddNewEventView()

    }
}
