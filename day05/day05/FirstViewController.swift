//
//  FirstViewController.swift
//  day05
//
//  Created by Kateryna KOSTRUBOVA on 4/8/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var segmentBar: UISegmentedControl!

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(Place.curLocation.coordinate, Place.curLocation.distSpan, Place.curLocation.distSpan), animated: true)
        for p in Place.locations{
             mapView.addAnnotation(p)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = false
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Pin else { return nil }
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "marker")
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.markerTintColor = annotation.pinColor
        }
        return view
    }

    let regionRadius: CLLocationDistance = 500
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    @IBAction func mapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
        
    }
    
    @IBAction func myLocation(_ sender: UIButton) {
        let status  = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        if (locationManager.location != nil){
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(locationManager.location!.coordinate,
                                                                      500, 500)
            mapView.setRegion(coordinateRegion, animated: true)
            self.centerMapOnLocation(location: locationManager.location!)
        } else {
            print("location not found")
        }
    }
    
}

