//
//  CheckBox.swift
//  EventPlanner
//
//  Created by Chicmic on 14/06/23.
//

import SwiftUI

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? Constants.Images.checkmark : Constants.Images.square)
            .foregroundColor(checked ? Constants.Colors.blueThemeColor : Color.secondary)
            .font(.title2)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}
