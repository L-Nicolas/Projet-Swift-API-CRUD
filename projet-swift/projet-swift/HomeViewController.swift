//
//  HomeViewController.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 13/02/2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var homePresentationLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnMesRapports: UIButton!
    @IBOutlet weak var newRapport: UIButton!
    @IBOutlet weak var rapportTableView: UITableView!
    
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    
    static let albumCellID = "_ALBUM_CELL_ID"
    var token: String = ""
    var rapportsTable: [Rapport] = [] {
        didSet {
            self.rapportTableView.reloadData()
        }
    }
    
    public class func newInstance(token: String) -> HomeViewController {
        let hvc = HomeViewController()
        hvc.token = token
        return hvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            scrollView.delegate = self
        rapportTableView.delegate = self
            scrollView.bounces = false
        rapportTableView.bounces = false
        rapportTableView.isScrollEnabled = false
        self.rapportTableView.dataSource = self
        
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.homePresentationLabel.text = "BIENVENUE DANS VOTRE ESPACE LOCATAIRE"
        self.homePresentationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.homePresentationLabel.textAlignment = NSTextAlignment.left;
        self.homePresentationLabel.numberOfLines = 4
        
        if self.token.isEmpty {
            let alert = UIAlertController(title: "Problème", message: "Impossible de récuprer vos rapports", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Recommencer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            
            Task {
                let result = await ListRapportWebService.getListRapportImm(token: self.token)
                dump(result)
                print("immeuuuuble")
                
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
                    //self.registerTableViewCells()
                }
            }
        }
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
    
    @IBAction func newRapport(_ sender: Any) {
        let nextController = CreateRapportViewController.newInstance(token: self.token)
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rapportsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.albumCellID) ?? UITableViewCell(style: .default, reuseIdentifier: HomeViewController.albumCellID)
        let rapport = self.rapportsTable[indexPath.row]
        print("affichage")
        dump(rapportsTable)
        cell.textLabel?.text = "Rapport : \(rapport.id)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y

        if scrollView == self.scrollView {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                rapportTableView.isScrollEnabled = true
            }
        }

        if scrollView == self.rapportTableView {
            if yOffset <= 0 {
                self.scrollView.isScrollEnabled = true
                self.rapportTableView.isScrollEnabled = false
            }
        }
    }
}
