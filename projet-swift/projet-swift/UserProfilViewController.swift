//
//  UserProfilViewController.swift
//  projet-swift
//
//  Created by Yanis on 01/03/2022.
//

import UIKit

class UserProfilViewController: UIViewController {
    
    
    var token: String = ""
    
    public class func newInstance(token: String) -> UserProfilViewController {
        let pvc = UserProfilViewController()
        pvc.token = token
        return pvc
    }

    @IBAction func logout(_ sender: Any) {
        let nextController = StartViewController.newInstance()
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
