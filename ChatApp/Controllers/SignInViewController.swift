//
//  SignInViewController.swift
//  ChatApp
//
//  Created by Barış Can Akkaya on 18.10.2021.
//

import UIKit
import Lottie
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    var animationView: AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInClicked(_ sender: UIButton) {
        if emailField.text != "" && passwordField.text != "" {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if let error = error {
                    self.callAlert(message: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
            }
        } else {
            callAlert(message: "Invalid email or password")
        }
    }
    
    func setLayout() {
        animationView = AnimationView(name: "dance")
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.75
        view.addSubview(animationView!)
        animationView?.play()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        animationView?.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(width)
        })
        if let animationView = animationView {
            emailField.snp.makeConstraints { make in
                make.top.equalTo(animationView.snp_bottomMargin).offset(height * 0.02)
                make.width.equalTo(width * 0.75)
                make.centerX.equalToSuperview()
            }
            passwordField.snp.makeConstraints { make in
                make.top.equalTo(emailField.snp_bottomMargin).offset(height * 0.05)
                make.width.equalTo(width * 0.75)
                make.centerX.equalToSuperview()
            }
            signInButton.snp.makeConstraints { make in
                make.top.equalTo(passwordField.snp_bottomMargin).offset(height * 0.05)
                make.width.equalTo(width * 0.75)
                make.centerX.equalToSuperview()
                make.height.equalTo(passwordField.layer.bounds.size.height * 1.5)
            }
            
        }
    }
    
    
    func callAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
