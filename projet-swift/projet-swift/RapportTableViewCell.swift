//
//  RapportTableViewCell.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 28/02/2022.
//

import UIKit

class RapportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titreRapportLabel: UILabel!
    @IBOutlet weak var dateRapportLabel: UILabel!
    @IBOutlet weak var typePrblmLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "RapportTableViewCell",
                                  bundle: nil)
        self.rapportTableView.register(textFieldCell,
                                forCellReuseIdentifier: "RapportTableViewCell")
    }*/
    
}
