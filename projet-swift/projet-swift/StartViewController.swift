//
//  StartViewController.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 13/02/2022.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    
    public class func newInstance() -> StartViewController {
        let svc = StartViewController()
        return svc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.startLabel.text = "SUPER GARDIEN"
        self.startLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.startLabel.textAlignment = NSTextAlignment.center;
        self.startLabel.numberOfLines = 4
    }
    
    
    
    @IBAction func startButton(_ sender: UIButton) {
        let nextController = AuthViewController.newInstance()
        self.navigationController?.pushViewController(nextController, animated: true)
    }

}
