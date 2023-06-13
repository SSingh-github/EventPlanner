//
//  EventDetailsView.swift
//  EventPlanner
//
//  Created by Chicmic on 08/06/23.

// person.fill.badge.plus symbol to join the event


import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @State var showMap = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                
                Text("Birthday party")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 4)
                Text("(Approved)")
                    .foregroundColor(.green)
            }
            .padding(.bottom, 20)
            
            VStack {
                Image("background")
                    .resizable()
                    .frame(height: 250)
                    .scaledToFit()
                    .cornerRadius(20)
                
                Text("This is a birthday party event to be held in the mohali sector 74, all of you who want to join can do so without any hesitation.")
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
                //Divider()
                
                Text("#hashtag1 #hashtag2 #hashtag3 #hashtag4 #hashtag5 #hashtag6")
                    .padding(.vertical, 8)
                    .multilineTextAlignment(.leading)
                
                HStack {
                   // Spacer()
                    Text("10+")
                        .bold()
                        .font(.system(size: 17))
                    Text("joined ")
                    Spacer()
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Constants.Colors.pinkColor)
                            .font(.system(size: 17))
                        Text("liked")
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 17))
                        Text("favourite")
                    }
                    //Spacer()
                }
                .foregroundColor(.gray)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.vertical)
                //Divider()
                HStack {
                    Text("Social and cultural events")
                        //.font(.title3)
                    Spacer()
                }
                //Divider()
                HStack {
                    Image("Location")
                    Text("Mohali, sector 74, phase 8b")
                        //.font(.title3)
                    Spacer()
                    
                    Button {
                        print("move to map view")
                        showMap.toggle()
                    } label: {
                        Image(systemName: "location.square.fill")
                            .font(.title)
                            .foregroundColor(Constants.Colors.blueThemeColor)
                    }
                    NavigationLink(destination: ContentView2(), isActive: $showMap) {
                        Text("")
                    }
                }
                .padding(.vertical)
                //Divider()
            }
            HStack {
                Text("Commencement")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                    Text("12, June, 2023")
                    Spacer()
                }
                .padding(.bottom)
                HStack {
                    Image(systemName: "clock")
                    Text("10:00 AM")
                    Spacer()
                }
            }
            .padding(.bottom)
            
            HStack {
                Text("Culmination")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                    Text("15, June, 2023")
                    Spacer()
                }
                .padding(.bottom)
                HStack {
                    Image(systemName: "clock")
                    Text("12:00 PM")
                    Spacer()
                }
            }
          //  Divider()
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .padding()
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(viewModel: MainTabViewModel())
    }
}
