//
//  MyEventsView.swift
//  EventPlanner
//
//  Created by Chicmic on 31/05/23.
//

import SwiftUI

struct MyEventsView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        
        NavigationView {
            List {  

                ForEach(Constants.Labels.options.indices, id:\.self) { index in
                    NavigationLink {
                        
                        switch index {
                        case 0:
                            FavouriteEvents(viewModel: viewModel)
                        case 1:
                            JoinedEvents(viewModel: viewModel)
                        case 2:
                            CreatedEvents(viewModel: viewModel)
                        default:
                            CalendarView(viewModel: viewModel)
                        }
                
                    } label: {
                        HStack {
                            Text(Constants.Labels.options[index])
                            Spacer()
                            
                            switch index {
                            case 0:
                                Image(systemName: Constants.Images.starFill)
                            case 1:
                                Image(systemName: Constants.Images.person2)
                            case 2:
                                Image(systemName: Constants.Images.rectanglePencil)
                            default:
                                Image(systemName: Constants.Images.calendar)
                            }
                        }
                        .frame(height: 50)
                        .font(.title3)
                        .fontWeight(.semibold)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding()
                    .background(.secondary.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle(Constants.Labels.list)
        }
    }
}

struct MyEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MyEventsView(viewModel: MainTabViewModel())
    }
}
