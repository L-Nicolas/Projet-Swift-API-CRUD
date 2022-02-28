//
//  RapportFactory.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import Foundation

class RapportFactory {
    
    class func rapport(from dict: [String: Any]) -> Rapport? {
        guard let id = dict["id"] as? Int,
              let type_probleme = dict["type_probleme"] as? String,
              let description = dict["description"] as? String,
              let etat = dict["etat"] as? String else {
                  return nil
              }
              
            return Rapport(id: "\(id)", type_probleme: type_probleme, description: description, etat: etat)
    }
    
    class func rapports(from array: [[String: AnyObject]]) -> [Rapport] {
        var out: [Rapport] = []
        for dict in array {
            if let r = RapportFactory.rapport(from: dict) {
                out.append(r)
            }
        }
        return out
    }
}
