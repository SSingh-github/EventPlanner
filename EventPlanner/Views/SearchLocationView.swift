//
//  SearchLocationView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI
import MapKit

struct SearchLocationView: View {
    @ObservedObject var viewModel: MainTabViewModel
    var body: some View {
            SearchView2(viewModel: viewModel)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchView2: View {
    
    @StateObject var locationManager: LocationManager = .init()
    @State var navigationTag: String?
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: Constants.Images.search)
                    .foregroundColor(.gray)
                TextFieldView(placeholder: Constants.Labels.Placeholders.findLocation, text: $locationManager.searchText)
            }
            
            if let places = locationManager.fetchedPlaces, !places.isEmpty {
                List {
                    ForEach(places, id:\.self) {place in
                        
                        Button {
                            if let coordinate = place.location?.coordinate {
                                locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                locationManager.addDraggablePin(coordinate: coordinate)
                                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                navigationTag = Constants.Labels.navTag
                            }
                            
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: Constants.Images.mappin)
                                    .font(.title2)
                                    .foregroundColor(.red)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(place.name ?? "")
                                        .font(.title3.bold())
                                        .foregroundColor(.primary)
                                    
                                    Text(place.locality ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            else {
                VStack {
                    Button {
                        
                        if let coordinate = locationManager.userLocation?.coordinate {
                            locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                            locationManager.addDraggablePin(coordinate: coordinate)
                            locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                        }
                        navigationTag = Constants.Labels.navTag
                    } label: {
                        Label {
                            Text(Constants.Labels.useCurrentLocation)
                                .font(.callout)
                        } icon: {
                            Image(systemName: Constants.Images.northLocation)
                        }
                        .foregroundColor(.green)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 20) {
                        Image(systemName: Constants.Images.search)
                            .font(.largeTitle)
                        Text(Constants.Labels.searchResults)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                }
            }

        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background {
            NavigationLink(tag: Constants.Labels.navTag, selection: $navigationTag) {
                MapViewSelection(viewModel: viewModel)
                    .environmentObject(locationManager)
            } label: {
            }
            .labelsHidden()
        }
    }
}


struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(viewModel: MainTabViewModel())
    }
}
