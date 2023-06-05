//
//  MainTabView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var viewModel: MainTabViewModel = MainTabViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = .systemBackground
        }
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label(Constants.Labels.explore, systemImage: Constants.Images.explore)
                       
                }
            
            SearchView()
                .tabItem {
                    Label(Constants.Labels.tabSearch, systemImage: Constants.Images.search)
                        
                }
            
            NewEventView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.new, systemImage: Constants.Images.addEvent)
                        
                }
            
            MyEventsView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.list, systemImage: Constants.Images.list)
                        
                }
            
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.profile, systemImage: Constants.Images.profile)
                       
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
