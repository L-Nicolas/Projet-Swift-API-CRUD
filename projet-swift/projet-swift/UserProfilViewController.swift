//
//  UserProfilViewController.swift
//  projet-swift
//
//  Created by Yanis on 01/03/2022.
//

import UIKit

class UserProfilViewController: UIViewController {
    
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var iName: UILabel!
    
    @IBOutlet weak var iFirstname: UILabel!
    
    @IBOutlet weak var iaddress: UILabel!
    
    @IBOutlet weak var iCity: UILabel!
    
    @IBOutlet weak var iCP: UILabel!
    
    @IBOutlet weak var iPhonenumber: UILabel!
    
    var infoProfil: [String : Any] = [:]
    
    public class func newInstance(info: [String : Any]) -> UserProfilViewController {
        let pvc = UserProfilViewController()
        pvc.infoProfil = info
        return pvc
    }

    @IBAction func logout(_ sender: Any) {
        let nextController = StartViewController.newInstance()
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email.text = infoProfil["email"] as? String
        self.iName.text = infoProfil["nom"] as? String
        //self.iaddress.text = infoProfil["adresse"] as? String
        self.iCity.text = infoProfil["ville"] as? String
        self.iCP.text = infoProfil["code_postal"] as? String
        self.iFirstname.text = infoProfil["prenom"] as? String
        var PN = infoProfil["telephone"] as! NSNumber
        self.iPhonenumber.text = PN.stringValue
    }
    

}
