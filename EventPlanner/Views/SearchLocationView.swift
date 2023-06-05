//
//  SearchLocationView.swift
//  EventPlanner
//
//  Created by Chicmic on 03/06/23.
//

import SwiftUI
import MapKit

struct SearchLocationView: View {
    var body: some View {
        NavigationView {
            SearchView2()
                .navigationBarHidden(true)
        }
    }
}

struct SearchView2: View {
    
    @StateObject var locationManager: LocationManager = .init()
    @State var navigationTag: String?
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                
                Text("Search Location")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextFieldView(placeholder: "find location here", text: $locationManager.searchText)
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
                                navigationTag = "MAPVIEW"
                            }
                            
                            
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
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
                Button {
                    
                    if let coordinate = locationManager.userLocation?.coordinate {
                        locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                        locationManager.addDraggablePin(coordinate: coordinate)
                        locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                    }
                    
                    navigationTag = "MAPVIEW"
                } label: {
                    Label {
                        Text("  use current location")
                            .font(.callout)
                    } icon: {
                        Image(systemName: "location.north.circle.fill")
                    }
                    .foregroundColor(.green)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background {
            NavigationLink(tag: "MAPVIEW", selection: $navigationTag) {
                MapViewSelection()
                    .environmentObject(locationManager)
                    .navigationBarHidden(true)
            } label: {
            }
            .labelsHidden()

        }
    }
}

struct MapViewSelection: View {
    // location = place.name + place.locality
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
            
            if let place = locationManager.pickedMark {
                VStack(spacing: 15) {
                    Text("confirm location")
                        .font(.title2.bold())
                    
                    HStack(spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.name ?? "")
                                .font(.title3.bold())
                            
                            Text(place.locality ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    
                    Button {
                        
                    } label: {
                        Text("confirm location")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle (cornerRadius: 10, style: .continuous)
                                    .fill(.green)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundColor(.white)
                            .ignoresSafeArea()
                    }

                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onDisappear {
            locationManager.pickedMark = nil
            locationManager.pickedLocation = nil
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
    }
}


struct MapViewHelper: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}


struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView()
    }
}
