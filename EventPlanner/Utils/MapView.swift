//
//  MapView.swift
//  EventPlanner
//
//  Created by Chicmic on 27/06/23.
//

import Foundation
import MapKit
import UIKit
import SwiftUI


struct MapView: UIViewRepresentable {
    
    //MARK: PROPERTIES
    
    typealias UIViewType = MKMapView
    
    @Binding var directions: [String]
    @Binding var destination: (Double, Double)
    @StateObject var locationManger = LocationManager()
    
    
    //MARK: METHODS
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        //userLocation holds the coordinates of the current user location
        let _ = CLLocationCoordinate2D(latitude: locationManger.userLocation?.coordinate.latitude ?? 0, longitude: locationManger.userLocation?.coordinate.longitude ?? 0)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.711214, longitude: 76.690276), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 30.711214, longitude: 76.690276))
        //30.378180, 76.776695
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destination.0, longitude: destination.1)) // placemark for ambala
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 30.711214, longitude: 76.690276)
        annotation1.title = Constants.Labels.startingLocation
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: destination.0, longitude: destination.1)
        annotation2.title = Constants.Labels.destinationLocation
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate {response, error in
            guard let route = response?.routes.first else {return}
            mapView.addAnnotations([annotation1, annotation2])
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
