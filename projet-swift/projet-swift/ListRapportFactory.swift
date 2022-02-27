//
//  ListRapportFactory.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import Foundation

class ListRapportFactory {
    
    class func listRapport(from dict: [String: Any]) -> ListRapport? {
        guard let id = dict["id"] as? Int,
              let rapports = dict["photos"] as? [[String: Any]] else {
                  return nil
              }
        return ListRapport(id: "\(id)", rapports: RapportFactory.rapports(from: rapports))
    }
}
