//
//  ThirdWelcomeView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

struct ThirdWelcomeView: View {
    
    @ObservedObject var viewModel: WelcomeViewModel

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
            Button {
                viewModel.showSheet.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 60)
                        .foregroundColor(Constants.Colors.blueThemeColor)
                        .cornerRadius(10)
                    Text(Constants.Labels.getStarted)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 50)
            }
            .fullScreenCover(isPresented: $viewModel.showSheet) {
                LoginSignupView()
            }
        }
    }
}

//struct ThirdWelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThirdWelcomeView()
//    }
//}
