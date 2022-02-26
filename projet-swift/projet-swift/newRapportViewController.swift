//
//  newRapportViewController.swift
//  projet-swift
//
//  Created by Yanis on 26/02/2022.
//

import UIKit

class newRapportViewController: UIViewController {
    
    var myToken: [String:String]!
    

    
    @IBOutlet weak var rapportSubject: UITextField!
    
    @IBOutlet weak var sendRapportButton: UIButton!
    
    public class func newInstance(myToken: [String:String]) -> newRapportViewController {
        let rvc = newRapportViewController()
        rvc.myToken = myToken
        return rvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func sendRapport(_ sender: Any) {
        guard let mysubject = self.rapportSubject.text else {
                  return
              }
        guard let token = myToken["token"] else {
            return
        }
        print(token)
        
        Task {
            let cr = createRapport()
            let result = await cr.myCreateRapport(mysubject: mysubject, usertoken: token)
            /*if(result == [:]){
                self.presentationLabel.text = "Vérifier vos identifiants"
            }else {
                let nextController = HomeViewController.newInstance(myToken: result)
                self.navigationController?.pushViewController(nextController, animated: true)
            }*/

        }
        
    }

}
