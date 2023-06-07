//
//  MainTabView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//


import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: MainTabViewModel = MainTabViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = .systemBackground
        }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            ExploreView()
                .tabItem {
                    Label(Constants.Labels.explore, systemImage: Constants.Images.explore)
                       
                }
                .tag(Tab.explore)
            
            SearchView()
                .tabItem {
                    Label(Constants.Labels.tabSearch, systemImage: Constants.Images.search)
                        
                }
                .tag(Tab.search)
            
            NewEventView(viewModel: viewModel)
                .id(appState.rootViewId) 
                .tabItem {
                    Label(Constants.Labels.new, systemImage: Constants.Images.addEvent)
                        
                }
                .tag(Tab.createEvent)
            
            MyEventsView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.list, systemImage: Constants.Images.list)
                        
                }
                .tag(Tab.myEvents)
            
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Label(Constants.Labels.profile, systemImage: Constants.Images.profile)
                       
                }
                .tag(Tab.profile)
        }
        .accentColor(Constants.Colors.blueThemeColor)
        .tabViewStyle(DefaultTabViewStyle())
        .fullScreenCover(isPresented: $viewModel.showWelcomeViewModel) {
            WelcomeTabView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
