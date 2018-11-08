//
//  AgentLocationsController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-25.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AgentLocationsController: UIViewController {
    
    let cellId = "cellId"
    
    let getLocationJson = GetLocationJSON()
    var locations = [LocationDataModel]() {
        didSet{
            DispatchQueue.main.async {
                self.locationCV.reloadData()
            }
        }
    }
    
    let profileView = AgentProfileView()
    var profile: UIView?
    
    let locationCVView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var locationCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: self.locationCVView.frame, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Agent Location"
        view.backgroundColor = .white
        fetchLocations()
        self.locationCV.register(AgentLocationCell.self, forCellWithReuseIdentifier: cellId)
        setupViews()
        
    }
    
    private func fetchLocations() {
        self.getLocationJson.getLocationJSON { (locationDataModel) in
            self.locations = locationDataModel
        }
    }
    
    private func formAddressString(location: LocationDataModel) -> String {
        guard let streetNo = location.streetNo else {return ""}
        guard let streetName =  location.streetName else {return ""}
        guard let city = location.city else {return ""}
        guard let country = location.country else {return ""}
        guard let zipcode = location.zipPostalCode else {return ""}
        let addressString = "\(streetNo) \(streetName) \(city), \(country), \(zipcode)"
        return addressString
    }
    
    private func setupViews() {
        profile = profileView.profileView
        view.addSubview(profile!)
        view.addSubview(locationCVView)
        locationCVView.addSubview(locationCV)

        profile?.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.17)
        profileView.setupProfileView()
        locationCVView.anchor(profile?.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        locationCV.anchor(locationCVView.topAnchor, left: locationCVView.leftAnchor, bottom: locationCVView.bottomAnchor, right: locationCVView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}

extension AgentLocationsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCV.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AgentLocationCell
        let location = locations[indexPath.item]
        cell.nameLabel.text = location.name
        cell.addressLabel.text = formAddressString(location: location)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.width, height: ScreenSize.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = locations[indexPath.item]
        let layout = UICollectionViewFlowLayout()
        let agentProfileController = AgentProfileController(collectionViewLayout: layout)
        guard let id = location.id else {return}
        UserDefaults.standard.set(id, forKey: "locationId")
        LoginController.GlobalLoginIDs.locationId = id 
        agentProfileController.currentLocation = location
        let navProfileController = UINavigationController(rootViewController: agentProfileController)
        present(navProfileController, animated: true) {
        }
    }
}


