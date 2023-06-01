//
//  WelcomeTabView.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import SwiftUI

struct WelcomeTabView: View {
    
    @StateObject var viewModel: WelcomeViewModel = WelcomeViewModel()
    
    var body: some View {
        TabView {
            FirstWelcomeView(viewModel: viewModel)
            SecondWelcomeView(viewModel: viewModel)
            ThirdWelcomeView(viewModel: viewModel)
        }
        .background(Color.black)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct WelcomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTabView()
    }
}
