//
//  SheetView.swift
//  EventPlanner
//
//  Created by Chicmic on 08/06/23.
//

import SwiftUI

struct SheetView: View {
    @State var title = ""
    @State var description = ""
    @State var selectedOption = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.Labels.Questions.title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            TextFieldView(placeholder: Constants.Labels.Placeholders.title, text: $title)
                //.padding()
                .font(.title3)
                .accentColor(Constants.Colors.blueThemeColor)
                .disableAutocorrection(true)
            
            HStack {
                Spacer()
                Text(Constants.Labels.category)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                Spacer()
                Picker(Constants.Labels.selectOption, selection: $selectedOption) {
                    ForEach(Constants.Labels.eventTypes, id: \.self) { eventType in
                        Text(eventType)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Spacer()
                //.frame(maxWidth: .infinity)
            //.padding()
            }
            
            
            Text(Constants.Labels.addDescription)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            TextEditor(text: $description)
                //.overlay(Color.blue)
                //.padding()
                .frame(height: 200)
                .cornerRadius(20)
                .shadow(radius: 2)
        }
        .padding()
        .accentColor(Constants.Colors.blueThemeColor)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
