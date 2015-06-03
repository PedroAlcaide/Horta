//
//  GardenController.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class GardenController: NSObject {
    static let sharedInstance = GardenController();

    private var itemArray: [layout_item_horta]
    private var linked_IDCanteiro: UILabel!;
    private var linked_itemImage: UIImageView!;
    private var linked_nomeResponsavel: UILabel!;
    private var linked_nomeItem: UILabel!;
//    private var item: layout_item_horta!;
        
    override init(){
        itemArray = [];
    }
    //-------------------------------------------------------------------------
    func linkNomeItemWithUI( object: UILabel ) {
        linked_nomeItem = object;
    }
    //-------------------------------------------------------------------------
    func linkNomeResponsavelWithUI( object: UILabel ) {
        linked_nomeResponsavel = object;
    }
    //-------------------------------------------------------------------------
    func linkItemImageWithUI( img: UIImageView ) {
        linked_itemImage = img;
    }
    //-------------------------------------------------------------------------
    func linkCanteiroIDWithUI( object: UILabel ){
        linked_IDCanteiro = object;
    }
    //-------------------------------------------------------------------------
    func updateInfo( id: Int ){
        let item: layout_item_horta = itemArray[ id ];
        linked_IDCanteiro.text = "#" + String( item.idCanteiro + 1);
        linked_itemImage.image = item.imgView.image;
        linked_nomeResponsavel.text = item.getNomeResponsavel();
        linked_nomeItem.text = item.getNomeItem();
    }
    //-------------------------------------------------------------------------
    func getItens() -> [UIView] {
        return itemArray;
    }
    //-------------------------------------------------------------------------
    func setNomeResponsavel( # id: Int, nome: String ) {
        let item: layout_item_horta = itemArray[ id ];
        item.setNomeResponsavel( nome );
        linked_nomeResponsavel.text = nome;
        updateInfo( id );
    }
    //-------------------------------------------------------------------------
    func setNomeItem( # id:  Int, nome: String ){
        let item: layout_item_horta = itemArray[ id ];
        item.setNomeItem( nome );
        linked_nomeItem.text = nome;
        updateInfo( id );
    }
    //-------------------------------------------------------------------------
    func setItemImg( # id: Int, img: UIImage ){
        let item: layout_item_horta = itemArray[ id ];
        item.imgView.image = img;
        updateInfo( id );
    }
    //-------------------------------------------------------------------------
    func addItem( #idCanteiro: Int, imgItem: UIImage ) -> () {
        var newItem = NSBundle.mainBundle().loadNibNamed("layout_item_horta", owner: self, options: nil )[0] as! layout_item_horta;
        newItem.setCanteiroID( idCanteiro );
        newItem.setImage( imgItem );
        
        itemArray.append( newItem );
    }
    //-------------------------------------------------------------------------
    func removeItem( id: Int ){
        var idx: Int;
        
        itemArray.removeAtIndex( id );        
        updateInfo( 0 );
    }
    //-------------------------------------------------------------------------
}