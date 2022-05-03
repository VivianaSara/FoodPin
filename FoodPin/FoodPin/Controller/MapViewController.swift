//
//  MapViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 03.05.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet private var mapView: MKMapView!
    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.getLocation(), completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }

            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]

                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.getName()
                annotation.subtitle = self.restaurant.getType()
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate

                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })

        mapView.delegate = self

        self.mapView.showsCompass = true
        self.mapView.showsScale = true
        self.mapView.showsTraffic = true
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        // Reuse the annotation if possible
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }

        annotationView?.glyphText = "😝"
        annotationView?.markerTintColor = UIColor.orange
        return annotationView
    }
}
