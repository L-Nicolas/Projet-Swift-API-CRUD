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
    
    @IBOutlet weak var homeTabBar: UITabBarItem!
    @IBOutlet weak var rapportTabBar: UITabBarItem!
    @IBOutlet weak var accountTabBar: UITabBarItem!
    var myToken: [String:String]!
    
    public class func newInstance(myToken: [String:String]) -> HomeViewController {
        let hvc = HomeViewController()
        hvc.myToken = myToken
        return hvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.homePresentationLabel.text = myToken["token"]
        self.homePresentationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.homePresentationLabel.textAlignment = NSTextAlignment.left;
        self.homePresentationLabel.numberOfLines = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.leftBarButtonItem = nil
    }


}
