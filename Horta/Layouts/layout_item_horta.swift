//
//  layout_item_horta.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class layout_item_horta: UIView {
    private var gardenController = GardenController.sharedInstance;
    
    @IBOutlet weak var labelIDCanteiro: UILabel!;
    @IBOutlet weak var btnUpdateInfo: UIButton!;
    @IBOutlet weak var imgView: UIImageView!;
    @IBOutlet weak var lblResponsavel: UILabel!;
    
    var idCanteiro: Int;
    private var imgItem: UIImage!;
    private var nomeResponsavel: String?;
    private var nomeItem: String?;

//    init(){
//        
//    }

    required init?(coder aDecoder: NSCoder) {
        self.idCanteiro = 0;
        self.nomeResponsavel = "";
        self.nomeItem = "";
        //fatalError("init(coder:) has not been implemented")
        super.init( coder: aDecoder );
    }
    //--------------------------------------------------------------------------
    @IBAction func updateInfo() {
        gardenController.updateInfo( self.idCanteiro );
    }
    //--------------------------------------------------------------------------
    func setNomeItem( nome: String ) {
        self.nomeItem = nome;
    }
    //--------------------------------------------------------------------------
    func setImage( img: UIImage ){
        imgItem = img;
        imgView.image = imgItem;
    }
    //--------------------------------------------------------------------------
    func setNomeResponsavel( nome: String ){
        self.nomeResponsavel = nome;
        lblResponsavel.text = self.nomeResponsavel;
    }
    //--------------------------------------------------------------------------
    func setCanteiroID( id: Int ) {
        self.idCanteiro = id;
        labelIDCanteiro.text = "#" + String( id + 1 );
    }
    //--------------------------------------------------------------------------
    func getNomeResponsavel() -> String? {
        return self.nomeResponsavel!;
    }
    //--------------------------------------------------------------------------
    func getNomeItem() -> String? {
        return self.nomeItem!;
    }
    //--------------------------------------------------------------------------
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
