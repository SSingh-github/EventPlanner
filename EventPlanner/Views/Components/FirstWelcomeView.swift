//
//  FirstWelcomeView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

struct FirstWelcomeView: View {
    
    @ObservedObject var viewModel: WelcomeViewModel
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(Constants.Labels.skip) {
                        viewModel.showSheet.toggle()
                    }
                    .foregroundColor(.white)
                    .fullScreenCover(isPresented: $viewModel.showSheet) {
                        LoginSignupView()
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}

//struct FirstWelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstWelcomeView()
//    }
//}
