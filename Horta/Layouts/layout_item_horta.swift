//
//  layout_item_horta.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class layout_item_horta: UIView {
    
    @IBOutlet weak var label: UILabel!;
    
    func setLabelText( text: String?) {
        label.text = text;
    }
//    var view: UIView!
//    
//    override init( frame: CGRect ) {
//        super.init( frame: frame );
//        xibSetup();
//    }
//    
//    required init( coder aDecoder: NSCoder ){
//        super.init( coder: aDecoder );
//        xibSetup();
//    }
//    
//    func xibSetup() {
//        view = loadViewFromNib();
//        view.frame = bounds;
//        
//        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
//        
//        addSubview( view );
//    }
//    
//    func loadViewFromNib() -> UIView {
//       // let bundle = NSBundle( forClass: self.dynamicType );
//       // let nib    = UINib( nibName: "layout_item_horta", bundle: bundle );
//        
//       // let view = nib.instantiateWithOwner( self, options: nil )[0] as! UIView;
//        let view = NSBundle.mainBundle().loadNibNamed( "layout_item_horta", owner: self, options: nil )[0] as! UIView;
//        
//        return view;
//    }
   /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
