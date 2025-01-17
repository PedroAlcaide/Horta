//
//  GardenController.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import UIKit

class GardenController: NSObject {
    static let sharedInstance = GardenController();

    //private var itemArray: [layout_item_horta]
    private var productArray: Array<layout_item_horta> = []
    
//    private var linked_IDCanteiro: UILabel!;
//    private var linked_itemImage: UIImageView!;
//    private var linked_nomeResponsavel: UILabel!;
//    private var linked_nomeItem: UILabel!;
//    private var item: layout_item_horta!;
        
//    override init(){
//        itemArray = [];
//    }
    
//    //-------------------------------------------------------------------------
//    func linkNomeItemWithUI( object: UILabel ) {
//        linked_nomeItem = object;
//    }
//    //-------------------------------------------------------------------------
//    func linkNomeResponsavelWithUI( object: UILabel ) {
//        linked_nomeResponsavel = object;
//    }
//    //-------------------------------------------------------------------------
//    func linkItemImageWithUI( img: UIImageView ) {
//        linked_itemImage = img;
//    }
//    //-------------------------------------------------------------------------
//    func linkCanteiroIDWithUI( object: UILabel ){
//        linked_IDCanteiro = object;
//    }
    //-------------------------------------------------------------------------
//    func updateInfo( id: Int ){
//        let item: layout_item_horta = itemArray[ id ];
//        linked_IDCanteiro.text = "#" + String( item.idCanteiro + 1);
//        linked_itemImage.image = item.imgView.image;
//        linked_nomeResponsavel.text = item.getNomeResponsavel();
//        linked_nomeItem.text = item.getNomeItem();
//    }
    //-------------------------------------------------------------------------
    func getItems() -> Array<layout_item_horta>? {
        
        return self.productArray
    }
    //-------------------------------------------------------------------------
    func setNomeResponsavel( id  id: Int, nome: String ) {
        let item: layout_item_horta = self.productArray[ id ];
        item.setNomeResponsavel( nome );
//        linked_nomeResponsavel.text = nome;
//        updateInfo( id );
    }
    //-------------------------------------------------------------------------
    func setNomeItem( id  id:  Int, nome: String ){
        let item: layout_item_horta = self.productArray[ id ];
        item.setNomeItem( nome );
//        linked_nomeItem.text = nome;
//        updateInfo( id );
    }
    //-------------------------------------------------------------------------
    func setItemImg( id  id: Int, img: UIImage ){
        let item: layout_item_horta = self.productArray[ id ];
        item.imgView.image = img;
//        updateInfo( id );
    }
    //-------------------------------------------------------------------------
    func addItem( idCanteiro idCanteiro: Int, imgItem: UIImage, delegate: UpdateItemDisplayDelegate ) -> () {
        let item = NSBundle.mainBundle().loadNibNamed("layout_item_horta", owner: self, options: nil )[0] as! layout_item_horta;
        
        let product = Product()
        
        product.name = "Novo Produto"
        product.quantity = 10
        
        item.product = product
//        newItem.setCanteiroID( idCanteiro );
        item.setImage( imgItem );
        item.productDelegate = delegate
        
        self.productArray.append( item )
    }
    //-------------------------------------------------------------------------
    func removeItem( id: Int ){
        //var idx : Int;
        
        self.productArray.removeAtIndex( id );
        //updateInfo( 0 );
    }
    //-------------------------------------------------------------------------
}