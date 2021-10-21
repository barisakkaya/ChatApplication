//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Barış Can Akkaya on 19.10.2021.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTableView: UITableView!
    
    let db = Firestore.firestore()
    var messages = [Message]()
    var me = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
        messageTableView.dataSource = self
        setLayout(height: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width)
        getMessages()
    }
    @IBAction func logoutClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Do you want to logout?", message: "If you choose yes, you will logout!", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let cancelAction = UIAlertAction(title: "Yes", style: .default) { action in
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "goToRoot", sender: self)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getMessages() {
        db.collection("Chats")
            .order(by: "date")
            .addSnapshotListener { (querySnapshot, error) in
                self.messages.removeAll()
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let snapshot = querySnapshot?.documents {
                        for doc in snapshot {
                            let data = doc.data()
                            if let messageSender = data["sender"] as? String, let messageBody = data["message"] as? String {
                                let newMessage = Message(sender: messageSender, messageBody: messageBody)
                                print("Sender \(messageSender)")
                                self.messages.append(newMessage)
                            }
                            
                        }
                        DispatchQueue.main.async {
                            if self.messages.count > 0 {
                                self.messageTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendMessageClicked(_ sender: UIButton) {
        if let message = messageField.text, let sender = Auth.auth().currentUser?.email {
            db.collection("Chats").addDocument(data: [
                "sender": sender,
                "message": message,
                "date": Date().timeIntervalSince1970
            ]) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageField.text = ""
                    }
                }
            }
        }
    }
    
    
    func setLayout(height: CGFloat, width: CGFloat) {
        messageTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.leading.trailing.equalToSuperview()
        }
        messageView.snp.makeConstraints { make in
            make.top.equalTo(self.messageTableView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        messageField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(width * 0.8)
            make.left.equalTo(width * 0.02)
            make.height.equalToSuperview().multipliedBy(0.70)
        }
        sendButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(width * 0.84)
            make.width.equalTo(width * 0.14)
            make.height.equalToSuperview().multipliedBy(0.70)
        }
    }
    
    func setCellLayoutLeft(cell: inout MessageTableViewCell, height: CGFloat, width: CGFloat) {
        cell.contentView.frame.size.width = width
        cell.label.snp.makeConstraints { make in
            make.leading.equalTo(width * 0.05)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(height * 0.07)
            make.top.equalTo(height * 0.015)
            make.bottom.equalTo(height * -0.015)
        }
        cell.label.backgroundColor = .white
        cell.label.layer.cornerRadius = 10
        cell.label.layer.masksToBounds = true
        
    }
    func setCellLayoutRight(cell: inout MessageTableViewCell, height: CGFloat, width: CGFloat) {
        cell.contentView.frame.size.width = width
        cell.label.snp.makeConstraints { make in
            make.trailing.equalTo(width * -0.05)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(height * 0.07)
            make.top.equalTo(height * 0.015)
            make.bottom.equalTo(height * -0.015)
        }
        cell.label.backgroundColor = UIColor(named: "whatsapp")
        cell.label.layer.cornerRadius = 10
        cell.label.layer.masksToBounds = true
    }
    func closeKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        var cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        
        if message.sender == Auth.auth().currentUser?.email {
            setCellLayoutRight(cell: &cell, height: height, width: width)
            print("Hwargi right")
            
        } else {
            setCellLayoutLeft(cell: &cell, height: height, width: width)
            print("Hwargi left")
        }
        
        cell.label.text = message.messageBody
        
        print("message \(message.messageBody) \(message.sender)")

        return cell
    }
}

extension UILabel {

open override func draw(_ rect: CGRect) {
    let inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    super.draw(rect.inset(by: inset))
    
}}
