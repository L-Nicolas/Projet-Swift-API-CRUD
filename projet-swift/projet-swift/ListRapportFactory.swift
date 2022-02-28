//
//  ListRapportFactory.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import Foundation

class ListRapportFactory {
    
    class func listRapport(from dict: [String: AnyObject]) -> ListRapport? {
        guard let rapports = dict["rapport"] as? [[String: AnyObject]] else {
                  return nil
              }
        return ListRapport(rapports: RapportFactory.rapports(from: rapports))
    }
}
