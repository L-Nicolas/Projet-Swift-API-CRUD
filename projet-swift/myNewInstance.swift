//
//  myNewInstance.swift
//  projet-swift
//
//  Created by Yanis on 26/02/2022.
//

import Foundation
import UIKit

class myNewInstance {

    func myNewInstance(token: [String:String])->UIViewController{
        let ControllerToken = UIViewController()
        ControllerToken.token = token
        return ControllerToken
    }
}
