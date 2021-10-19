//
//  ViewController.swift
//  ChatApp
//
//  Created by Barış Can Akkaya on 18.10.2021.
//

import UIKit
import SnapKit
import Lottie

class LoginViewController: UIViewController {
    
    var whatsappAnimation: AnimationView?
    var width: CGFloat?
    var height: CGFloat?
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        width = UIScreen.main.bounds.size.width
        height = UIScreen.main.bounds.size.height
        showAnimation(width: width!, height: height!)
        setLayout(width: width!, height: height!)
    }
    
    @IBAction func signInClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    @IBAction func signUpCilcked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUp", sender: self)
    }
    
    func showAnimation(width: CGFloat, height: CGFloat) {
        whatsappAnimation = AnimationView(name: "whatsapp")
        whatsappAnimation?.loopMode = .loop
        whatsappAnimation?.animationSpeed = 1.0
        view.addSubview(whatsappAnimation!)
        whatsappAnimation?.play()
        whatsappAnimation?.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(width * 0.8)
            make.height.equalTo(width * 0.8)
        })
    }
    
    func setLayout(width: CGFloat, height: CGFloat) {
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor(red: CGFloat(37.0/255.0), green: CGFloat(211.0/255.0), blue: CGFloat(102.0/255.0), alpha: CGFloat(1.0)).cgColor
        
        if let whatsappAnimation = whatsappAnimation {
            signInButton.snp.makeConstraints { make in
                make.top.equalTo(whatsappAnimation.snp_bottomMargin).offset(height * 0.25)
                make.width.equalTo(width * 0.75)
                make.height.equalTo(height * 0.07)
                make.centerX.equalToSuperview()
            }
            signUpButton.snp.makeConstraints { make in
                make.top.equalTo(signInButton.snp_bottomMargin).offset(height * 0.05)
                make.width.equalTo(width * 0.75)
                make.height.equalTo(height * 0.07)
                make.centerX.equalToSuperview()
            }
        }
        
        
    }
}


