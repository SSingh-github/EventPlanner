//
//  MapViewCoordinator.swift
//  EventPlanner
//
//  Created by Chicmic on 09/06/23.
//

import Foundation
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 5
        return renderer
    }
}
