//
//  ViewController.swift
//  rush01
//
//  Created by Liudmyla POHRIBNIAK on 4/13/19.
//  Copyright © 2019 Liudmyla POHRIBNIAK. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class customCell: UITableViewCell {
    
    @IBOutlet weak var proposedLocationLabel: UILabel!
}

extension ViewController: GMSMapViewDelegate {
    
    
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = mapView
    }
    
    
    func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyDuCofUuvYuYWUZplyQlGcYr90Fgo1Brss"
        
        let searchurl = NSURL(string : url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)
        let searchrequest = NSMutableURLRequest(url : searchurl! as URL)
        
        let taskSearch = URLSession.shared.dataTask(with: searchrequest as URLRequest) {
            (data, response, error) in
            if error != nil {
                print("Error")
                return
            } else if data != nil {
                do {
                    let dic : NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    let routes = dic["routes"] as? [NSDictionary]
                    if dic["status"] as! String == "ZERO_RESULTS" {
                        print("Routes not Found")
                    }
                    if routes != nil{
                        for route in routes! {
                            let routeOverviewPolyline = route["overview_polyline"] as? NSDictionary
                            if(routeOverviewPolyline != nil){
                                var points = ""
                                for (key, value) in routeOverviewPolyline! {
                                    if ("\(key)" == "points"){
                                        points = value as! String
                                        
                                        DispatchQueue.main.async {
                                            
                                            let path = GMSPath.init(fromEncodedPath: points)
                                            let polyline = GMSPolyline.init(path: path)
                                            polyline.strokeWidth = 5
                                            polyline.strokeColor = UIColor.black
                                            polyline.geodesic = true
                                            polyline.map = self.mapView
                                            self.mapView.animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(path: path!)))
                                        }
                                    }
                                }
                            }
                        }
                    }else{
                        print("Routes not Found")
                    }
                }catch {
                     print("Routes not Found")
                    return
                }
            }
        }
        taskSearch.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath.row == 0) {
//            let cell = dropOffTable.dequeueReusableCell(withIdentifier: "predictCell") as! customCell
//            cell.proposedLocationLabel.text = predictions[indexPath.row].attributedFullText.string
//        } else {
                let cell = dropOffTable.dequeueReusableCell(withIdentifier: "predictCell") as! customCell
                    cell.proposedLocationLabel.text = predictions[indexPath.row].attributedFullText.string
//        }

         return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placesClient.lookUpPlaceID(self.predictions[indexPath.row].placeID , callback: { (place, error) in
            if self.kostil {
                self.mapView.clear()
            }
            if tableView == self.pickUpTable {
                self.pickUpLocation.text = self.predictions[indexPath.row].attributedFullText.string
                self.start_loc = place?.coordinate
                if self.finish_loc == nil {
                    self.mapView.clear()
                    self.dropOffLocation.text = ""
                }
                self.createMarker(titleMarker: "Start", iconMarker: #imageLiteral(resourceName: "start"), latitude: (place?.coordinate.latitude)!, longitude: (place?.coordinate.longitude)!)
                
                self.kostil = false
            }else{
                self.dropOffLocation.text =  self.predictions[indexPath.row].attributedFullText.string
                self.finish_loc = place?.coordinate
                if self.start_loc == nil {
                    self.mapView.clear()
                    self.pickUpLocation.text = ""
                }
                self.createMarker(titleMarker: "finish", iconMarker: #imageLiteral(resourceName: "finish"), latitude: (place?.coordinate.latitude)!, longitude: (place?.coordinate.longitude)!)
                self.kostil = false
            }
            if self.start_loc != nil && self.finish_loc != nil {
                self.drawPath(startLocation: self.start_loc, endLocation: self.finish_loc)
                self.start_loc = nil
                self.finish_loc = nil
                
                self.kostil = true
            }
            self.mapView.camera = GMSCameraPosition(latitude:  (place?.coordinate.latitude)!, longitude: (place?.coordinate.longitude)!, zoom: 16)
            self.pickUpLocation.resignFirstResponder()
            self.dropOffLocation.resignFirstResponder()
            self.view.sendSubview(toBack: self.dropOffView)
            self.view.sendSubview(toBack: self.pickUpView)
        })
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ViewController: UITextFieldDelegate {

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        predictions = []
        pickUpTable.reloadData()
        dropOffTable.reloadData()
        
        if textField == pickUpLocation {
            view.bringSubview(toFront: pickUpView)
            view.sendSubview(toBack: dropOffView)
        }else{
            view.bringSubview(toFront: dropOffView)
            view.sendSubview(toBack: pickUpView)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.sendSubview(toBack: dropOffView)
        view.sendSubview(toBack: pickUpView)
        textField.resignFirstResponder()
//        predictions = []
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        placesClient.findAutocompletePredictions(fromQuery: textField.text!, bounds: GMSCoordinateBounds().includingCoordinate((locationManager.location?.coordinate)!), boundsMode: GMSAutocompleteBoundsMode(rawValue: 0)!, filter: nil, sessionToken: sessionToken) { (res, error) in
            self.predictions = res!

                if textField == self.pickUpLocation {
                    self.pickUpTable.reloadData()
                }else{
                    self.dropOffTable.reloadData()
                }
            
//                print("Place id ---->   ", self.predictions[0].placeID)
//                print("attributedFullText ---->   ", self.predictions[0].attributedFullText.string)
//                print("attributedPrimaryText ---->   ", self.predictions[0].attributedPrimaryText.string)
                
        
                
                
//                self.placesClient.fetchPlace(fromPlaceID: self.predictions[0].placeID , placeFields: self.fields, sessionToken: self.sessionToken, callback: { (place, error) in
////                    print(error)
////                    print(place?.coordinate)
//                })
                
            
        }
    
        
        return true
    }
}

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    let sessionToken = GMSAutocompleteSessionToken.init()
    var predictions : [GMSAutocompletePrediction] = []
    let fields: GMSPlaceField = GMSPlaceField(rawValue: 0)!
    var start_loc: CLLocationCoordinate2D!
    var finish_loc: CLLocationCoordinate2D!
    var kostil: Bool = false
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pickUpLocation: UITextField!
    @IBOutlet weak var dropOffLocation: UITextField!
    @IBOutlet weak var pickUpView: UIView!
    @IBOutlet weak var dropOffView: UIView!
    
    @IBOutlet weak var dropOffTable: UITableView!
    @IBOutlet weak var pickUpTable: UITableView!
    
    @IBAction func mapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .normal
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .terrain
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        placesClient = GMSPlacesClient.shared()
        
        pickUpLocation.delegate = self
        dropOffLocation.delegate = self
        
        
        dropOffTable.delegate = self
        pickUpTable.delegate = self
        pickUpTable.dataSource = self
        dropOffTable.dataSource = self
        
        
        view.bringSubview(toFront: pickUpLocation)
        view.bringSubview(toFront: dropOffLocation)

        mapView.delegate =  self
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.mapType = .terrain
    }



}

