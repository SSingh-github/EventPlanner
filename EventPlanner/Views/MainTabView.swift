//
//  MainTabView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var viewModel: MainTabViewModel = MainTabViewModel()
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label(Constants.Labels.explore, systemImage: Constants.Images.explore)
                        .environment(\.symbolVariants, .none)
                }
            
            SearchView()
                .tabItem {
                    Label(Constants.Labels.tabSearch, systemImage: Constants.Images.search)
                        .environment(\.symbolVariants, .none)
                }
            
            NewEventView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.new, systemImage: Constants.Images.addEvent)
                        .environment(\.symbolVariants, .none)
                }
            
            MyEventsView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.list, systemImage: Constants.Images.list)
                        .environment(\.symbolVariants, .none)
                }
            
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.profile, systemImage: Constants.Images.profile)
                        .environment(\.symbolVariants, .none)
                }
        }
        .accentColor(Constants.Colors.blueThemeColor)
        .tabViewStyle(DefaultTabViewStyle())
        .fullScreenCover(isPresented: $viewModel.showWelcomeViewModel) {
            WelcomeTabView()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
