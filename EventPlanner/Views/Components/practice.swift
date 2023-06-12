//
//  practice.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//


import SwiftUI
import MapKit


struct ContentView2: View {
    
  
    @State var directions: [String] = []
    @State var showDirectionsSheet = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            MapView(directions: $directions)
            
            Button {
                showDirectionsSheet.toggle()
            } label: {
                Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                    .font(.largeTitle)
                    .foregroundColor(Constants.Colors.blueThemeColor)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 10)
                    }
            }
            .disabled(directions.isEmpty)
            .padding(.bottom, 150)
            .padding(.trailing)
           
        }
        .sheet(isPresented: $showDirectionsSheet, content: {DirectionsView(directions: $directions)})
        .ignoresSafeArea()
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var directions: [String]
    @StateObject var locationManger = LocationManager()
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        //userLocation holds the coordinates of the current user location
        let userLocation = CLLocationCoordinate2D(latitude: locationManger.userLocation?.coordinate.latitude ?? 0, longitude: locationManger.userLocation?.coordinate.longitude ?? 0)
        
        //destination location holds the coordinates of the destination location
        //this variable will store the coordinates of the event i.e. event.longitude, event.latitude
        let destinationLocation = 0
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.711214, longitude: 76.690276), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 30.711214, longitude: 76.690276))
        //30.378180, 76.776695
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 30.378180, longitude: 76.776695)) // placemark for ambala
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate {response, error in
            guard let route = response?.routes.first else {return}
            mapView.addAnnotations([p1, p2])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                animated: true
                )
            
            self.directions = route.steps.map {$0.instructions} .filter {!$0.isEmpty}
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}
