//
//  ChatViewController.swift
//  EggMap
//
//  Created by Rey Cerio on 14/12/2018.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChatViewController: UICollectionViewController {
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let messageTextField: UITextField = {
        let tf = UITextField()
        //        tf.backgroundColor = .gray
        tf.placeholder = "enter message"
        return tf
    }()
    
    let sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        return button
    }()
    
    let micButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mic", for: .normal)
        return button
    }()
    
    let messages = ["sup", "Hey there, are you ready to party all the way to hollywood hills? Its gonna be lit AF, fam! We gonna Fuck the place up!", "Hey! It’s Melissa…I am just wondering if Stefan has arrived?", "What you up to?", "Hi Rey, Louisa said you dropped by SD today. The show in Vegas is called ‘KA’. It plays at the MGM GRAND. Incredible must see. Cheers!", "sup", "Hey there, are you ready to party all the way to hollywood hills? Its gonna be lit AF, fam! We gonna Fuck the place up!", "Hey! It’s Melissa…I am just wondering if Stefan has arrived?", "What you up to?", "Hi Rey, Louisa said you dropped by SD today. The show in Vegas is called ‘KA’. It plays at the MGM GRAND. Incredible must see. Cheers!"]
    let dates = ["99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM"]
    
    
    
    lazy var inputContainerView: UIView = {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ScreenSize.height * 0.09)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        setupContainerView(containerView: containerView)
        return containerView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gavin Benson"
        self.view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.keyboardDismissMode = .interactive
        self.collectionView!.register(ChatControllerFromCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupBackgroundView()
    }
    
    //initiating a view that sticks to the top of the keyboard
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    //make container view appear at bottom
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillAppear() {
        //Do something here
        inputContainerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ScreenSize.height * 0.07)
    }
    
    @objc func keyboardWillDisappear() {
        //Do something here
        inputContainerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ScreenSize.height * 0.09)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupContainerView(containerView: UIView) {
        containerView.addSubview(lineView)
        containerView.addSubview(self.messageTextField)
        containerView.addSubview(self.micButton)
        containerView.addSubview(self.sendButton)
        
        lineView.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        self.messageTextField.anchor(lineView.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.7, heightConstant: 0)
        self.micButton.anchor(lineView.bottomAnchor, left: messageTextField.rightAnchor, bottom: containerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.11, heightConstant: 0)
        self.sendButton.anchor(lineView.bottomAnchor, left: self.micButton.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.09)

    }
    
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatControllerFromCell
        
        cell.messageLbl.text = messages[indexPath.item]
        cell.dateLbl.text = dates[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = ScreenSize.height * 0.2
        let text = messages[indexPath.item]
        let date = dates[indexPath.item]
        let heightText = estimatedFrameForText(text: text).height
        let heightDate = estimatedFrameForText(text: date).height
        height = heightText + heightDate + 20
        return CGSize(width: ScreenSize.width, height: height)
    }
    
    //making the bubble frame be the same size as its content
    private func estimatedFrameForText(text: String) -> CGRect {
        //height has to arbitrarily large
        let size = CGSize(width: ScreenSize.width * 0.8, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
}
