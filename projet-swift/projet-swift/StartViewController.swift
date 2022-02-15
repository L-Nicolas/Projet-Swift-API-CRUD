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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLabel.text = "J'AI PAS DIDÉE ENFAITE"
        self.startLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.startLabel.textAlignment = NSTextAlignment.center;
        self.startLabel.numberOfLines = 4
    }
    
    
    
    @IBAction func startButton(_ sender: UIButton) {
        let nextController = AuthViewController.newInstance()
        self.navigationController?.pushViewController(nextController, animated: true)
    }

}
