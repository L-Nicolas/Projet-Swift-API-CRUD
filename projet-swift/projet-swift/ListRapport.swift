//
//  ListRapport.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import Foundation

class ListRapport: CustomStringConvertible {
    var description: String {
        var str = ""
        for rapport in self.rapports {
            str += "\(rapport)\n"
        }
        return str
    }
    let rapports: [Rapport]
    
    init(rapports: [Rapport]) {
        self.rapports = rapports
    }
}
