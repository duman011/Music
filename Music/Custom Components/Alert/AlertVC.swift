//
//  AlertVC.swift
//  Music
//
//  Created by Yaşar Duman on 9.11.2023.
//


import UIKit

class AlertVC: UIViewController {
    
    // MARK: - Properties
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    
    //MARK: - UI Elements
    lazy var containerView  = AlertContainerView()
    lazy var titleLabel     = TitleLabel(textAlignment: .center, fontSize: 20)
    lazy var messageLabel   = BodyLabel(textAlignment: .center)
    lazy var actionButton   = MusicButton(bgColor: .systemPink, color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")
    
    
    //MARK: - Initializers
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle   = title
        self.message      = message
        self.buttonTitle  = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviewsExt(containerView, titleLabel, actionButton, messageLabel)
        configureContainerView()
        configureTitleLabel()  
        configureActionButton()
        configureMessageLabel()
    }
    
    
    // MARK: - UI Configuration
    func configureContainerView() {
        containerView.centerInSuperview()
        containerView.anchor(size: .init(width: 280, height: 220))
    }
    
    func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        titleLabel.anchor(top: containerView.topAnchor,
                          leading: containerView.leadingAnchor,
                          trailing: containerView.trailingAnchor,
                          padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                          size: .init(width: 0, height: 28))
    }
    
    func configureMessageLabel(){
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        
        messageLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: actionButton.topAnchor,
                            trailing: containerView.trailingAnchor,
                            padding: .init(top: 8, left: 20, bottom: 12, right: 20))
      
    }
    
    func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        actionButton.anchor(leading: containerView.leadingAnchor,
                            bottom: containerView.bottomAnchor,
                            trailing: containerView.trailingAnchor,
                            padding: .init(top: 0, left: 20, bottom: 20, right: 20),
                            size: .init(width: 0, height: 44))
      
    }
    
    // MARK: - Actions
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
