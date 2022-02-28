//
//  CreateRapportViewController.swift
//  projet-swift
//
//  Created by Yanis on 27/02/2022.
//

import UIKit

class CreateRapportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var rapportPresentationLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myDescription: UITextField!
    var token: String = ""
    var select: String = ""
    
    let arr = ["serrurerie","plomberie","électricité","autre"]
    
    public class func newInstance(token: String) -> CreateRapportViewController {
        let hvc = CreateRapportViewController()
        hvc.token = token
        return hvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "serrurie")
        myTable.delegate = self
        myTable.dataSource = self
        self.rapportPresentationLabel.text = "CRÉATION D'UN RAPPORT"
        self.rapportPresentationLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.rapportPresentationLabel.textAlignment = NSTextAlignment.left;
        self.rapportPresentationLabel.numberOfLines = 2

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "serrurie", for: indexPath)
        cell.textLabel?.text = self.arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.select = arr[indexPath.row]
    }
    
    
    @IBAction func createMyRapport(_ sender: Any) {
        guard let iDescription = self.myDescription.text else {
                  return
              }
        if iDescription.isEmpty {
            let alert = UIAlertController(title: "Problème", message: "Veuillez remplir les champs", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            Task {
                let resReport = await sendReport().sendnewReport(myProblem: self.select, iDescription: iDescription, token: token)
                
                if resReport["data"]?["error"] as! Int == 1 {
                    let alert = UIAlertController(title: "Problème", message: resReport["data"]?["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("good")
                    //let nextController = HomeViewController.newInstance(result: result)
                    //self.navigationController?.pushViewController(nextController, animated: true)
                }
            }
        }
        
    }
    
 
    

}
