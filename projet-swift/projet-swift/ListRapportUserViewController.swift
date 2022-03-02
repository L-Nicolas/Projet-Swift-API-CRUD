//
//  ListRapportUserViewController.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import UIKit

class ListRapportUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var rapportPresentationLabel: UILabel!
    @IBOutlet weak var rapportTableView: UITableView!
    
    static let rapportCellID = "RapportTableViewCell"
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
        
        let nib = UINib(nibName: "RapportTableViewCell",bundle: nil)
        self.rapportTableView.register(nib,forCellReuseIdentifier: "RapportTableViewCell")
        self.rapportTableView.delegate = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RapportTableViewCell", for: indexPath) as! RapportTableViewCell
        cell.titreRapportLabel.text = "ggggefeeerererererererer"
        cell.idRapport.text = rapportsTable[indexPath.row].id
        cell.idRapport.isHidden = true
        cell.dateRapport.text = rapportsTable[indexPath.row].date
        cell.token.text = token
        cell.token.isHidden = true
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    private func registerTableViewCells() {
        let nib = UINib(nibName: ListRapportUserViewController.rapportCellID,bundle: nil)
        self.rapportTableView.register(nib,forCellReuseIdentifier: ListRapportUserViewController.rapportCellID)
    }
}
