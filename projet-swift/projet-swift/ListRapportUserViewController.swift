//
//  ListRapportUserViewController.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import UIKit

class ListRapportUserViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var rapportPresentationLabel: UILabel!
    @IBOutlet weak var rapportTableView: UITableView!
    
    static let albumCellID = "_ALBUM_CELL_ID"
    var token: String = ""
    var rapportsTable: [Rapport] = [] {
        didSet {
            self.rapportTableView.reloadData()
        }
    }
    
    public class func newInstance(token: String) -> ListRapportUserViewController {
        let lruvc = ListRapportUserViewController()
        lruvc.token = token
        return lruvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rapportPresentationLabel.text = "VOTRE ESPACE RAPPORTS"
        self.rapportPresentationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.rapportPresentationLabel.textAlignment = NSTextAlignment.left;
        self.rapportPresentationLabel.numberOfLines = 4
        self.rapportTableView.dataSource = self
        if self.token.isEmpty {
            let alert = UIAlertController(title: "Problème", message: "Impossible de récuprer vos rapports", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            Task {
                let result = await ListRapportWebService.getListRapport(token: self.token)
                dump(result)
                
                if result["error"] as! Int == 1 {
                    let alert = UIAlertController(title: "Problème", message: result["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    guard let resultData = result["data"] as? [Rapport] else {
                        return
                    }
                    dump(resultData[0])
                    self.rapportsTable = resultData
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rapportsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListRapportUserViewController.albumCellID) ?? UITableViewCell(style: .default, reuseIdentifier: ListRapportUserViewController.albumCellID)
        let rapport = self.rapportsTable[indexPath.row]
        print("affichage")
        dump(rapport
        )
        cell.textLabel?.text = "Rapport : \(rapport.id)"
        return cell
    }
}
