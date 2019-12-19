//
//  ViewController.swift
//  McKinleyTest
//
//  Created by Abhishek on 19/12/19.
//  Copyright © 2019 Evontech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    @IBOutlet weak var loginButtonBottomConstraitnt: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //remove notification on disppearign of the view to save memory leakage
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            loginButtonBottomConstraitnt.constant = keyboardSize.height + 48
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        loginButtonBottomConstraitnt.constant = 48
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        let loginURL = BASE_URL + "login"
        let param = ["email": idField.text ?? "",
                     "password" :pwdField.text ?? ""
            ] as [String : Any]
            
        RequestManager.sharedManager.connectToServerPost(urlString: loginURL, param: param) { [weak self] (res, err, status) in
            if res?["token"] as? String != nil {
                UserDefaults.standard.set(res?["token"] as? String, forKey: "token")
               self?.openController()
            }else if res?["error"] as? String != nil {
                self?.showAlert((res?["error"] as? String)!)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        idField.resignFirstResponder()
        pwdField.resignFirstResponder()
    }
    
    func showAlert(_ withTitle: String) {
        let alert = UIAlertController(title: "", message: withTitle, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    func openController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: WebViewController.storyboardID) as! WebViewController
        self.show(vc, sender: self)
    }
}

