//
//  Model.swift
//  day05
//
//  Created by Kateryna KOSTRUBOVA on 4/8/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var distSpan : CLLocationDegrees
    var pinColor : UIColor
    
    init(title: String, subtitle: String, lat: Double, long: Double, distSpan: CLLocationDegrees, pinColor : UIColor) {
        self.title = title
        self.subtitle = subtitle
        self.distSpan = distSpan
        self.coordinate = CLLocationCoordinate2DMake(lat, long)
        self.pinColor = pinColor
    }
}


class Place {
    public static var locations : [Pin] = [
        Pin(title: "UNIT Factory", subtitle: "Ukrainian National IT Factory", lat: 50.468852, long: 30.462159, distSpan: 2000, pinColor: UIColor.green),
        Pin(title: "Home", subtitle: "Yessss!!!", lat: 50.418500, long: 30.634446, distSpan: 2000, pinColor: UIColor.cyan),
        Pin(title: "New York", subtitle: "I want to visit you!", lat: 40.714270, long: -74.005970, distSpan: 2000, pinColor: UIColor.yellow),
        Pin(title: "Paris", subtitle: "Beautiful city!", lat: 48.856614, long: 2.352222, distSpan: 2000, pinColor: UIColor.red),
        ]
    public static var curLocation : Pin = Place.locations[0]
    
}
