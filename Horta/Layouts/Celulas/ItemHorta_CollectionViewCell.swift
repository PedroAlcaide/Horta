//
//  ItemHorta_CollectionViewCell.swift
//  Horta
//
//  Created by Felipe R. de Luca on 10/29/15.
//  Copyright © 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

//---------------------------------------------------------------------
class ItemHorta_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    
    var updateInfoDelegate: UpdateItemDisplayDelegate?
    var product: Product = Product()
    
    //---------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    //---------------------------------------------------------------------
    @IBAction func didSelectItem() {
        
        self.updateInfoDelegate?.updateInfoOnDisplay( self.product )
    }
    
    //---------------------------------------------------------------------

}
//---------------------------------------------------------------------
