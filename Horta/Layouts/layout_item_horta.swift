//
//  layout_item_horta.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

//----------------------------------------------------------------------
class layout_item_horta: UIView {
    //private var gardenController = GardenController.sharedInstance;
    
    @IBOutlet weak var labelIDCanteiro: UILabel!;
    @IBOutlet weak var btnUpdateInfo: UIButton!;
    @IBOutlet weak var imgView: UIImageView!;
    @IBOutlet weak var lblResponsavel: UILabel!;
    
    var product: Product?
    var productDelegate: UpdateItemDisplayDelegate?
    
    var idCanteiro: Int?
    private var imgItem: UIImage!
    private var nomeResponsavel: String?
    private var nomeItem: String?

//    init(){
//        
//    }

//    required init?(coder aDecoder: NSCoder) {
//        self.idCanteiro = 0;
//        self.nomeResponsavel = "";
//        self.nomeItem = "";
//        //fatalError("init(coder:) has not been implemented")
//        super.init( coder: aDecoder );
//    }
    //--------------------------------------------------------------------------
    @IBAction func updateInfo() {
      //  self.productDelegate?.updateInfoOnDisplay( self )
    }
    
//    //--------------------------------------------------------------------------
    func setNomeItem( nome: String ) {
        self.nomeItem = nome;
    }
//    //--------------------------------------------------------------------------
    func setImage( img: UIImage ){
        imgItem = img;
        self.imgView.image = imgItem;
    }
//    //--------------------------------------------------------------------------
    func setNomeResponsavel( nome: String ){
        self.nomeResponsavel = nome;
//        lblResponsavel.text = self.nomeResponsavel;
    }
//    //--------------------------------------------------------------------------
    func setCanteiroID( id: Int ) {
        self.idCanteiro = id;
//        labelIDCanteiro.text = "#" + String( id + 1 );
    }
//    //--------------------------------------------------------------------------
    func getNomeResponsavel() -> String? {
        return self.nomeResponsavel!;
    }
//    //--------------------------------------------------------------------------
    func getNomeItem() -> String? {
        return self.nomeItem!;
    }
//    //--------------------------------------------------------------------------
}
