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
                    ZStack {
                        Rectangle()
                            .frame(height: 50)
                            .foregroundColor( Constants.Colors.blueThemeColor)
                            .cornerRadius(10)
                        Text( Constants.Labels.Continue)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    .padding()
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
