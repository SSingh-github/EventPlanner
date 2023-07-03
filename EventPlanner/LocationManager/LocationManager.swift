//
//  LocationManager.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//

import Foundation

import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //MARK: PROPERTIES
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    @Published var searchText: String = ""
    @Published var fetchedPlaces: [CLPlacemark]?
    @Published var userLocation: CLLocation?
    @Published var pickedLocation: CLLocation?
    @Published var pickedMark: CLPlacemark?
   
    var cancellable: AnyCancellable?
    
    //MARK: INITIALIZER
    override init() {
        super.init()
        
        manager.delegate = self
        mapView.delegate = self
        
        manager.requestWhenInUseAuthorization()
        
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != "" {
                    self.fetchPlaces(value: value)
                }
                else {
                    self.fetchedPlaces = nil
                }
            })
    }
    
    
    //MARK: METHODS
    
    
    /// Fetches the list of places whose names matches with the string in the parameter
    ///
    ///  - Parameters:
    ///     - value: The string which is used to match to different places and fetch the corresponding places.
    ///
    func fetchPlaces(value: String) {
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                let response = try await MKLocalSearch(request: request).start()
                
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap({ item -> CLPlacemark? in
                        return item.placemark
                    })
                })
            }
            catch {
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error
    }
    
    /// This method handles the various cases of location authorization
    ///
    ///  - Parameters:
    ///     - manager: a CLLocationManager object which is used to perform various actions depending upon the permissions of the user.
    ///
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            handleLocationError()
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        case .restricted:
            print("")
        @unknown default:
            break
        }
    }
    
    /// This delegate method is used to perform action when the location is updated
    ///
    ///    - Parameters:
    ///       - manager: a CLLocationManager object which is used to perform various actions depending upon the permissions of the user.
    ///       - locations: an array of CLLocation objects which contains the locations in the order the user has updated
    ///
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        self.userLocation = currentLocation
    }
    
    func handleLocationError() {
        
    }
    
    /// Adds the draggale pin at the given coordinate which is used to highlight the location the user has selected
    ///
    ///    - Parameters:
    ///       - coordinate: the coordinate object which represents the current location the user has selected.
    ///
    func addDraggablePin(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = Constants.Labels.eventLocation
        mapView.addAnnotation(annotation)
    }
    
    /// This method is used to get the marker for the location
    ///
    ///   - Parameters:
    ///     - mapView: contains the map view object
    ///     - annotation: contains the annotation object
    ///
    ///   - Returns: the MKAnnotationView on the map view for the given annotation object.
    ///
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.Labels.eventPin)
        marker.isDraggable = true
        marker.canShowCallout = false
        return marker
    }
    
    /// This delegate method handles the change in the annotation on the map.
    ///
    ///   - Parameters:
    ///     - mapView: contains the map view object.
    ///     - view: contains the annotation view on the map view.
    ///     - newState: it contains the new state of the annotation view.
    ///     - oldState: represents the old state of the annotation view.
    ///
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let newLocation = view.annotation?.coordinate else {return}
        self.pickedLocation = .init(latitude: newLocation.latitude, longitude: newLocation.longitude)
        self.updatePlacemark(location: .init(latitude: newLocation.latitude, longitude: newLocation.longitude))
    }
    
    /// This helper method is used to update the placemark of the map view when the annotation is changed
    ///
    ///    - Parameters:
    ///     - location: represents the location object for updating the placemark
    ///
    func updatePlacemark(location: CLLocation) {
        Task {
            do {
                guard let place = try await reverseLocationCoordinates(location: location) else {return}
                await MainActor.run(body: {
                    self.pickedMark = place
                })
            }
            catch {
                
            }
        }
    }
    
    func reverseLocationCoordinates(location: CLLocation) async throws -> CLPlacemark? {
        let place = try await CLGeocoder().reverseGeocodeLocation(location).first
        return place
    }
}

