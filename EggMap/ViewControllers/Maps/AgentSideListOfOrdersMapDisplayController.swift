//
//  AgentSideListOfOrdersMapDisplayController.swift
//  EggMap
//
//  Created by Mei on 2018-10-08.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation

///MIGHT DELETE THIS LATER BECAUSE CLIENT AND AGENT CAN USE ORDERLISTMAPVIEWCONTROLLER TO DISPLAY LIST OF AVAILABILITY...
class AgentSideListOfOrdersMapDisplayController: UIViewController, CLLocationManagerDelegate {
    
    lazy var slideUpView = ClientSlideUpView(frame: CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: self.view.frame.height))
    
    var navRightButtonBool: Bool = false
    
    var addressString: String? {
        didSet{
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingLocation()
        }
    }
    //    var clientLocation : LocationAndScheduleByIdDataModel? {
    //        didSet{
    //            let locationById = GetLocationDetailsByIDJSON()
    //            guard let location = clientLocation else {return}
    //            addressString = locationById.formAddressString(location: location)
    //        }
    //    }
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
        let center = location.coordinate
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 18)
        mapView.animate(to: camera)
        guard let address = addressString else {return}
        geoCodeAddress(address: address, userPoint: center)
    }
    
    private func geoCodeAddress(address: String, userPoint: CLLocationCoordinate2D) {
        var coordinates = CLLocationCoordinate2D()
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                //put an alert here for no placemarks found
                print("GEOCODER: No Placemarks Found!")
            } else {
                guard let unwrappedCoord = placemarks?.first?.location?.coordinate else {return}
                coordinates = unwrappedCoord
                
                //to calculate the distance
                //                let userPoint = MKMapPointForCoordinate(userPoint)
                //                let addressPoint = MKMapPointForCoordinate(coordinates)
                //                let distance = MKMetersBetweenMapPoints(userPoint, addressPoint)
                //                if distance < 100000 {
                let newMarker = GMSMarker(position: coordinates)
                newMarker.title = address
                newMarker.map = self.mapView
                self.mapView.animate(toLocation: coordinates)
                //to display user's coordinates
                //                    self.mapView.isMyLocationEnabled = true
                //                }
            }
        }
    }
    
    fileprivate func setupViews() {
        view.addSubview(mapView)
        mapView.fillSuperview()
        setupAgentSlideUpView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SlideUpview", style: .plain, target: self, action: #selector(navAgentRightButtonTapped))
    }
    
    
}

extension AgentSideListOfOrdersMapDisplayController {
    private func setupAgentSlideUpView() {
        view.addSubview(slideUpView)
        //        slideUpView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(slideUpViewSwiped)))
        //
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleAgentGesture(gesture:)))
        swipeUp.direction = .up
        slideUpView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleAgentGesture(gesture:)))
        swipeDown.direction = .down
        slideUpView.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func handleAgentGesture(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .up:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                var bottomOfNavBar = ScreenSize.height * 0.1
                if DeviceType.isIphone6Plus || DeviceType.isIphone6 {
                    bottomOfNavBar = ScreenSize.height * 0.09
                }
                self.slideUpView.frame.origin.y = self.view.frame.minY + bottomOfNavBar
            }) { (_) in
                //completion handler
            }
        case .down:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.slideUpView.frame.origin.y = self.view.frame.maxY
            }) { (_) in
                //completion handler
            }
        default:
            print("No Swipes")
        }
    }
    
    @objc func navAgentRightButtonTapped() {
        if navRightButtonBool == false {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                print("slide up button pressed = \(self.navRightButtonBool)")
                self.slideUpView.frame.origin.y = ScreenSize.height * 0.75
            }) { (_) in
                //completion handler
            }
            navRightButtonBool = true
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                print("slide up button pressed = \(self.navRightButtonBool)")
                self.slideUpView.frame.origin.y = self.view.frame.maxY
            }) { (_) in
                //completion handler
            }
            navRightButtonBool = false
        }
    }
    
    
}

