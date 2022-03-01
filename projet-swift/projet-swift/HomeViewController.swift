//
//  HomeViewController.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 13/02/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homePresentationLabel: UILabel!
    @IBOutlet var navBar: [UITabBar]!
    
    
    @IBOutlet weak var btnMesRapports: UIButton!
    @IBOutlet weak var newRapport: UIButton!
    var token: String = ""
    
    public class func newInstance(token: String) -> HomeViewController {
        let hvc = HomeViewController()
        hvc.token = token
        return hvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.homePresentationLabel.text = "BIENVENUE DANS VOTRE ESPACE LOCATAIRE"
        self.homePresentationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.homePresentationLabel.textAlignment = NSTextAlignment.left;
        self.homePresentationLabel.numberOfLines = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.leftBarButtonItem = nil
    }
    
    
    @IBAction func listRapportUser(_ sender: Any) {
        let nextController = ListRapportUserViewController.newInstance(token: self.token)
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    @IBAction func displayProfil(_ sender: Any) {
        Task {
            let resProfil = await ProfilData().getDataForProfil(token: token)
            if resProfil["error"] as! Int == 1 {
                let alert = UIAlertController(title: "Problème", message: resProfil["data"]?["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                guard let arr = resProfil["data"] as? [[String:Any]] else {
                    return
                }
                let finalarr = arr.first
                let nextController = UserProfilViewController.newInstance(info: finalarr!)
                self.navigationController?.pushViewController(nextController, animated: true)
        }
        }
    }
    
    @IBAction func newRapport(_ sender: Any) {
        let nextController = CreateRapportViewController.newInstance(token: self.token)
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}
