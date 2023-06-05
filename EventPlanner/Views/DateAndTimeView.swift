//
//  DateAndTimeView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI

struct DateAndTimeView: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    var body: some View {
        ScrollView {
            VStack {
                DateTimePickerView(viewModel: viewModel)
                NavigationLink(destination: SearchLocationView(viewModel: viewModel)) {
                    Text("continue")
                }
            }
        }
        
    }
}

struct DateAndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateAndTimeView(viewModel: AddEventViewModel())
    }
}
