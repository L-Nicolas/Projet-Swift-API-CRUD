//
//  ListRapport.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import Foundation

class ListRapport: CustomStringConvertible {
    var description: String {
        var str = "Album \(self.id):\n"
        for rapport in self.rapports {
            str += "\(rapport)\n"
        }
        return str
    }
    
    let id: String
    let rapports: [Rapport]
    
    init(id: String, rapports: [Rapport]) {
        self.id = id
        self.rapports = rapports
    }
}
