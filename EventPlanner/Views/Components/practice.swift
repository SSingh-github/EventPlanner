//
//  practice.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//


import SwiftUI


struct ContentView2: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    
    var body: some View {
        VStack {
            Text("Date and Time")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 40)
            Picker("", selection: $viewModel.selected) {
                ForEach(Constants.Labels.segments, id:\.self) { segment in
                    Text(segment)
                        .tag(segment)
                }
            }
            .pickerStyle(.segmented)
            .background(Constants.Colors.blueThemeColor)
            .cornerRadius(8)
            .padding()
            
            if viewModel.selected == "Start" {
                DatePicker("", selection: $viewModel.startDate, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
                
                DatePicker("Select the Start time:", selection: $viewModel.startDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
            }
            else {
                DatePicker("", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
                
                DatePicker("Select the End time:", selection: $viewModel.endDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
            }
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2(viewModel: AddEventViewModel())
    }
}
