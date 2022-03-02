//
//  RapportTableViewCell.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 02/03/2022.
//

import UIKit

class RapportTableViewCell: UITableViewCell {

    @IBOutlet var titreRapportLabel: UILabel!
    @IBOutlet var btnDetailRapport: UIButton!
    @IBOutlet weak var token: UILabel!
    @IBOutlet weak var idRapport: UILabel!
    
    @IBOutlet weak var dateRapport: UILabel!
    @IBOutlet weak var typePrblRapport: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func goDetailRapport(_ sender: Any) {
        print(idRapport.text ?? " ")
        print(token.text ?? " ")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
