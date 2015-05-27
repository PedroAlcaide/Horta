//
//  CustomCell.swift
//  Horta
//
//  Created by Pedro Alcaide on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    
 
    @IBOutlet weak var Local: UILabel!
    @IBOutlet weak var NomeHorta: UILabel!
    
    @IBOutlet weak var FotoHorta: UIImageView!
    @IBOutlet weak var ImagemFixa2: UIImageView!
    @IBOutlet weak var ImagemFixa1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
