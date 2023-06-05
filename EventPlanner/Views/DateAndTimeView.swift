//
//  DateAndTimeView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI

struct DateAndTimeView: View {
    var body: some View {
        ScrollView {
            VStack {
                DateTimePickerView()
                NavigationLink(destination: SearchLocationView()) {
                    Text("continue")
                }
            }
        }
        
    }
}

struct DateAndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateAndTimeView()
    }
}
