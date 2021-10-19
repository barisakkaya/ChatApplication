//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by Barış Can Akkaya on 18.10.2021.
//

import UIKit
import SnapKit
import Lottie

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    var animationView: AnimationView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
        setLayout()
        
    }
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
    }
    
    func setLayout() {
        animationView = AnimationView(name: "signUp")
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1.0
        view.addSubview(animationView!)
        animationView?.play()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        animationView?.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(width * 0.70)
            make.height.equalTo(width * 0.70)
        })
        if let animationView = animationView {
            firstNameField.snp.makeConstraints { make in
                make.top.equalTo(animationView.snp_bottomMargin).offset(height * 0.01)
                make.width.equalTo(width * 0.75)
                make.centerX.equalToSuperview()
            }
            lastNameField.snp.makeConstraints { make in
                make.top.equalTo(firstNameField.snp_bottomMargin).offset(height * 0.05)
                make.centerX.equalToSuperview()
                make.width.equalTo(width * 0.75)
            }
            emailField.snp.makeConstraints { make in
                make.top.equalTo(lastNameField.snp_bottomMargin).offset(height * 0.05)
                make.centerX.equalToSuperview()
                make.width.equalTo(width * 0.75)
            }
            passwordField.snp.makeConstraints { make in
                make.top.equalTo(emailField.snp_bottomMargin).offset(height * 0.05)
                make.centerX.equalToSuperview()
                make.width.equalTo(width * 0.75)
            }
            signUpButton.snp.makeConstraints { make in
                make.top.equalTo(passwordField.snp_bottomMargin).offset(height * 0.10)
                make.centerX.equalToSuperview()
                make.width.equalTo(width * 0.75)
                make.height.equalTo(passwordField.layer.bounds.size.height * 1.5)
            }
            
        }
        
    }
    
    func closeKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
