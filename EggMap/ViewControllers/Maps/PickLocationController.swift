//
//  PickLocationController.swift
//  EggMap
//
//  Created by Mei on 2018-12-20.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation

class PickLocationController: UIViewController, CLLocationManagerDelegate {
    
    var userLocation = CLLocationCoordinate2D()
    let mapView = GMSMapView()
    let locationManager = CLLocationManager()
    let buttonContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        userLocation = location.coordinate
        let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 18)
        mapView.animate(to: camera)

    }
    
    fileprivate func setupViews() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.fillSuperview()
        mapView.isMyLocationEnabled = true
    }
}

extension PickLocationController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let alert = UIAlertController(title: "Share Location", message: "Share which location?", preferredStyle: .alert)
        let userLocAction = UIAlertAction(title: "User location", style: .default) { (action) in
            print(self.userLocation)
        }
        let pickedLocAction = UIAlertAction(title: "Picked location", style: .default) { (action) in
            print(coordinate)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: {
                //handle completion
            })
        }
        alert.addAction(userLocAction)
        alert.addAction(pickedLocAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true) {
            
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        print("POI tapped \(name) \(location)")
    }
}
