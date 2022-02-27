//
//  ListRapportUserViewController.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import UIKit

class ListRapportUserViewController: UIViewController, UITableViewDataSource  {
    
    @IBOutlet weak var rapportPresentationLabel: UILabel!
    @IBOutlet weak var rapportTableView: UITableView!
    
    static let albumCellID = "_ALBUM_CELL_ID"
    static var tokenSav: String = ""
    var rapportsTable: [ListRapport] = [] {
        didSet {
            self.rapportTableView.reloadData()
        }
    }
    
    public class func newInstance(token: String) -> ListRapportUserViewController {
        let lruvc = ListRapportUserViewController()
        self.tokenSav = token
        print("token save")
        print(self.tokenSav)
        print("token env")
        print(token)
        return lruvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rapportPresentationLabel.text = "VOTRE ESPACE RAPPORTS"
        self.rapportPresentationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.rapportPresentationLabel.textAlignment = NSTextAlignment.left;
        self.rapportPresentationLabel.numberOfLines = 4
        if ListRapportUserViewController.tokenSav.isEmpty {
            let alert = UIAlertController(title: "Problème", message: "Impossible de récuprer vos rapports", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            Task {
                let result = await ListRapportWebService.getListRapport(token: ListRapportUserViewController.tokenSav)
                
                if result["data"]?["error"] as! Int == 1 {
                    let alert = UIAlertController(title: "Problème", message: result["data"]?["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if let resultData = result["data"]?["data"] as? [[String:Any]],
                       let res = resultData.first {
                            print(res)
                    }
                    self.rapportsTable = []
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListRapportUserViewController.albumCellID) ?? UITableViewCell(style: .default, reuseIdentifier: ListRapportUserViewController.albumCellID)
        let album = self.rapportsTable[indexPath.row]
        cell.textLabel?.text = "photos"
        return cell
    }

}
