//
//  ReusableMenu.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-21.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class SlideInMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let localizer = LocalizedPListStringGetter()
    var agentTitleStringArray = [String]()
    var clientTitleStringArray = [String]()
    
    var sideBarTableView : UITableView!
    weak var delegate: SideBarViewDelegate?
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(r: 54, g: 55, b: 56, a: 1)
        self.clipsToBounds = true
        setupTitleArray()
        sideBarTableView = UITableView()
        sideBarTableView.translatesAutoresizingMaskIntoConstraints = false
        setupViews()

        sideBarTableView.delegate = self
        sideBarTableView.dataSource = self
        sideBarTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        sideBarTableView.allowsSelection = true
//        sideBarTableView.bounces = false
//        sideBarTableView.showsVerticalScrollIndicator = false
        sideBarTableView.backgroundColor = .clear
        sideBarTableView.separatorStyle = .none

    }
    
    func setupTitleArray() {
        guard let editProfile = localizer.parseLocalizable().editProfile?.value,
        let orderSummary = localizer.parseLocalizable().orderSummary?.value,
        let xboMarketShop = localizer.parseLocalizable().xboMarketShop?.value,
        let earningsSummary = localizer.parseLocalizable().earningsSummary?.value,
        let scanTool = localizer.parseLocalizable().scanTool?.value,
        let logout = localizer.parseLocalizable().logout?.value else {return}
        
        agentTitleStringArray = [editProfile, orderSummary, xboMarketShop, earningsSummary, "Compensation", scanTool, logout]
        clientTitleStringArray = [editProfile, orderSummary, xboMarketShop, logout]
    }
    
    func setupViews() {
        self.addSubview(sideBarTableView)
        sideBarTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sideBarTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        sideBarTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sideBarTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func setupTableView() {
        sideBarTableView.delegate = self
        sideBarTableView.dataSource = self
        sideBarTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        sideBarTableView.allowsSelection = true
        sideBarTableView.bounces = false
        sideBarTableView.showsVerticalScrollIndicator = false
        sideBarTableView.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LoginController.GlobalLoginIDs.userType == "1" {
            return clientTitleStringArray.count
        } else {
            return agentTitleStringArray.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        var title = String()
        if LoginController.GlobalLoginIDs.userType == "1" {
            title = clientTitleStringArray[indexPath.row]
        } else {
            title = agentTitleStringArray[indexPath.row]
        }
        
        if indexPath.row == 0 {
            setupHeaderCell(cell: cell)
        } else {
            setupTableCell(cell: cell, indexPath: indexPath, title: title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return ScreenSize.height * 0.2
        } else {
            return ScreenSize.height * 0.1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sidebarDidSelect(row: Row(row: indexPath.row))
    }
    
    func setupTableCell(cell: UITableViewCell, indexPath: IndexPath, title: String) {
        cell.textLabel?.textColor = .white
        cell.imageView?.image = #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal)
        cell.textLabel?.text = title
    }
    
    func setupHeaderCell(cell: UITableViewCell) {
        //modify this later maybe with constraints instead
        let cellImage = UIImageView(frame: CGRect(x: 15, y: 10, width: 80, height: 80))
        cellImage.layer.cornerRadius = cellImage.frame.height / 2
        cellImage.layer.masksToBounds = true
        cellImage.contentMode = .scaleAspectFill
        cellImage.image = #imageLiteral(resourceName: "Cartoon Egg").withRenderingMode(.alwaysOriginal)
        cell.addSubview(cellImage)
        
        let cellNameLbl = UILabel()
        cellNameLbl.text = "LongnameHere Longlastnamehere"
        cellNameLbl.font = UIFont.systemFont(ofSize: 17)
        cellNameLbl.textColor = .white
        cellNameLbl.numberOfLines = 0
        cellNameLbl.lineBreakMode = .byWordWrapping
        cell.addSubview(cellNameLbl)
        
        let cellEditLbl = UILabel()
        cellEditLbl.text = localizer.parseLocalizable().editProfile?.value
        cellEditLbl.font = UIFont.systemFont(ofSize: 17)
        cellEditLbl.textColor = .white
        cell.addSubview(cellEditLbl)
        
        cellEditLbl.anchor(self.topAnchor, left: cellImage.rightAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.09, leftConstant: ScreenSize.height * 0.05, bottomConstant: 0, rightConstant: 0, widthConstant: cell.frame.width * 0.4, heightConstant: cell.frame.height * 0.2)
        
        cellNameLbl.anchor(cellImage.bottomAnchor, left: cell.leftAnchor, bottom: nil, right: nil, topConstant: 6, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: cell.frame.width * 0.7, heightConstant: cell.frame.height * 0.4)
    }
}

protocol SideBarViewDelegate: class {
    func sidebarDidSelect(row: Row)
}


enum Row: String {
    case editProfile
    case orderSummary
    case xboMarketShop
    case earningsSummary
    case compensation
    case scanTool
    case logout
    case none
    
    init(row: Int) {
        switch row {
        case 0: self = .editProfile
        case 1: self = .orderSummary
        case 2: self = .xboMarketShop
        case 3: if LoginController.GlobalLoginIDs.userType == "1" {
                    self = .logout
                } else {
                    self = .earningsSummary
                }
        case 4: self = .compensation
        case 5: self = .scanTool
        case 6: self = .logout
        default: self = .none
        }
    }
}
