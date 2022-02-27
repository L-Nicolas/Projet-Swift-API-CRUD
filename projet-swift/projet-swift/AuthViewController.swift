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
        
        Task {
            let auth = Auth()
            let result = await auth.loginUser(email: log, password: pwd)
            
            if(result == [:]){
                self.presentationLabel.text = "Vérifier vos identifiants"
            }else {
                let nextController = HomeViewController.newInstance(myToken: result)
                self.navigationController?.pushViewController(nextController, animated: true)
            }

        }
        
        /*let alert = UIAlertController(title: "Problème", message: result["message"], preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
    }
    
    
}
