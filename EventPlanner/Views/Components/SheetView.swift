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
            Text("What's the title?")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            TextFieldView(placeholder: "Title", text: $title)
                //.padding()
                .font(.title3)
                .accentColor(Constants.Colors.blueThemeColor)
                .disableAutocorrection(true)
            
            HStack {
                Spacer()
                Text("Category")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                Spacer()
                Picker("Select an option", selection: $selectedOption) {
                    ForEach(Constants.Labels.eventTypes, id: \.self) { eventType in
                        Text(eventType)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Spacer()
                //.frame(maxWidth: .infinity)
            //.padding()
            }
            
            
            Text("Add some description")
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
