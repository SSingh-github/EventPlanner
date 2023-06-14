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
    @Environment(\.colorScheme) var colorScheme
    var indexOfEvent: Int = 0

    var body: some View {
    
        ZStack {
            ScrollView(showsIndicators: false) {
                    VStack {
                        
                        Text(viewModel.detailedEventForExplore?.title ?? "no title")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4)
                        Text(viewModel.detailedEventForExplore?.is_approved ?? true ? "(Approved)" : "(Not Approved)")
                            .foregroundColor(viewModel.detailedEventForExplore?.is_approved ?? true ? .green : .red)
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
//                        Image("background")
//                            .resizable()
//                            .frame(height: 250)
//                            .scaledToFit()
//                            .cornerRadius(20)
                        if let imageUrl = viewModel.detailedEventForExplore?.image, !imageUrl.isEmpty {
                            // Show the image using the URL
                            AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    // Placeholder view while the image is being loaded
                                    HStack {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                                            .frame(width: 200, height: 150)
                                            .scaleEffect(3)
                                            
                                        Spacer()
                                    }
                                case .success(let image):
                                    // Display the loaded image
                                    image
                                        .resizable()
                                        .frame(height: 250)
                                        .scaledToFit()
                                        .cornerRadius(20)
                                case .failure(_):
                                    // Show an error placeholder if the image fails to load
                                   Rectangle()
                                        //.resizable()
                                        .frame(height: 250)
                                        .scaledToFit()
                                        .cornerRadius(20)
                                @unknown default:
                                    // Handle any future cases if needed
                                    EmptyView()
                                }                            }
                        }
                    else {
                        Rectangle()
                            //.resizable()
                            .frame(height: 250)
                            .scaledToFit()
                            .cornerRadius(20)
                    }
                        
                        Text(viewModel.detailedEventForExplore?.description ?? "no description")
                            .multilineTextAlignment(.leading)
                            .padding(.vertical)
                        //Divider()
                        
//                        ScrollView {
//                            HStack {
//                                ForEach(0...20, id:\.self) { _ in
//                                    Text("hello world")
//                                }
//                            }
//                        }
                        
                        Text(viewModel.getHashtagString())
                            .padding(.vertical, 8)
                            .multilineTextAlignment(.leading)
//
                        
                        
                        HStack {
                           // Spacer()
                            Text("\(viewModel.detailedEventForExplore?.event_attendees_count ?? 0)")
                                .bold()
                                .font(.system(size: 17))
                            Text("attendees ")
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
                            Text(Constants.Labels.eventTypes[(viewModel.detailedEventForExplore?.event_category_id ?? 2) - 1])
                                //.font(.title3)
                            Spacer()
                        }
                        //Divider()
                        HStack {
                            Image("Location")
                            Text(viewModel.detailedEventForExplore?.location ?? "no location")
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
                            NavigationLink(destination: ContentView2(destination: (viewModel.detailedEventForExplore?.latitude ?? 0, viewModel.detailedEventForExplore?.longitude ?? 0)), isActive: $showMap) {
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
                            Text(viewModel.detailedEventForExplore?.start_date ?? "00")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: "clock")
                            Text(viewModel.detailedEventForExplore?.start_time ?? "00")
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
                            Text(viewModel.detailedEventForExplore?.end_date ?? "00")
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack {
                            Image(systemName: "clock")
                            Text(viewModel.detailedEventForExplore?.end_time ?? "00")
                            Spacer()
                        }
                    }
                    
                    Divider()
                    
                    HStack {
//                        Image("background")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 80, height: 80)
//                            .clipShape(Circle())
                        if let imageUrl = viewModel.detailedEventForExplore?.user_image, !imageUrl.isEmpty {
                            // Show the image using the URL
                            AsyncImage(url: URL(string: Constants.API.URLs.baseUrl + imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    // Placeholder view while the image is being loaded
                                    HStack {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                                            .frame(width: 200, height: 150)
                                            .scaleEffect(3)
                                            
                                        Spacer()
                                    }
                                case .success(let image):
                                    // Display the loaded image
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                case .failure(_):
                                    // Show an error placeholder if the image fails to load
                                   Rectangle()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                @unknown default:
                                    // Handle any future cases if needed
                                    EmptyView()
                                }                            }
                        }
                    else {
                        Rectangle()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.detailedEventForExplore?.user_name ?? "user")
                                .font(.title3)
                            Text("\(viewModel.detailedEventForExplore?.follower_count ?? 0) followers")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        
                        Button {
                            print("follow the user")
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .frame(width: 80,height: 30)
                                    .cornerRadius(14)
                                Text("follow")
                                    .foregroundColor(colorScheme == .light ? .white: .black)
                                    .padding()
                            }
                        }

                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Button {
       
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 60)
                                .foregroundColor(Constants.Colors.blueThemeColor)
                                .cornerRadius(10)
                            Text("Join event")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(height: 60)
                    .padding(.top, 40)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .padding()
            
            if viewModel.showDetailedEventForExplore {
                LoadingView()
            }
        }
        .onAppear {
            viewModel.showDetailedEventForExplore = true
            NetworkManager.shared.eventDetails(viewModel: viewModel, eventId: viewModel.events[indexOfEvent].id)
            print(viewModel.showDetailedEventForExplore, "is the value of boolean")
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(viewModel: MainTabViewModel())
    }
}
