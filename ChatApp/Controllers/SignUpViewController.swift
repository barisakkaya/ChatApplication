//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by Barış Can Akkaya on 18.10.2021.
//

import UIKit
import SnapKit
import Lottie
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    var animationView: AnimationView?
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
        setLayout()
        
    }
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        if emailField.text != "" && passwordField.text != "" {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if let error = error {
                    self.callAlert(message: error.localizedDescription)
                } else {
                    self.sendUserInfosToDb()
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
            }
        } else {
            callAlert(message: "Invalid email or password")
        }
    }
    
    func setLayout() {
        passwordField.textContentType = .newPassword
        passwordField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; max-consecutive: 2; minlength: 8;")
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
    
    func callAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendUserInfosToDb() {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        let data = ["firstName: ": firstNameField.text!, "lastName": lastNameField.text!, "email": emailField.text!] as [String: Any]
        ref = db.collection("users").addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }




}
