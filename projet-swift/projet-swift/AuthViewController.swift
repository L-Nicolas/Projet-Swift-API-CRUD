//
//  AuthViewController.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 29/01/2022.
//

import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var presentationLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var subscribeButton: UIButton!
    
    public class func newInstance() -> AuthViewController {
        let avc = AuthViewController()
        return avc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        self.presentationLabel.text = "ACCÉDEZ À VOTRE COMPTE"
        self.presentationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.presentationLabel.textAlignment = NSTextAlignment.left;
        self.presentationLabel.numberOfLines = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func touchSubscribe(_ sender: Any) {
        guard let log = self.loginTextField.text,
              let pwd = self.passwordTextField.text else {
                  return
              }
        
        if log.isEmpty || pwd.isEmpty {
            let alert = UIAlertController(title: "Problème", message: "Veuillez remplir les champs", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            
            Task {
                let result = await Auth().loginUser(email: log, password: pwd)
                
                if result["error"] as! Int == 1 {
                    let alert = UIAlertController(title: "Problème", message: result["data"]?["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    guard let token = result["data"] as? [[String:Any]] else {
                        return
                    }
                    let finalToken = token.first
                    let nextController = HomeViewController.newInstance(token: finalToken!["token"] as! String)
                    self.navigationController?.pushViewController(nextController, animated: true)
                }
            }
        }
    }
    
}
