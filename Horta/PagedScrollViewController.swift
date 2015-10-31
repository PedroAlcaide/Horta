//
//  PagedScrollViewController.swift
//  Horta
//
//  Created by Pedro Alcaide on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

//---------------------------------------------------------------------------
class PagedScrollViewController: UIViewController, UIScrollViewDelegate, UpdateItemDisplayDelegate {
    
    var gardenController = GardenController.sharedInstance;
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var lblIDCanteiro: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nomeResponsavel: UILabel!
    @IBOutlet var nomeItem: UILabel!
    @IBOutlet var itemHortaContainer: UIView!
    
   // var pageImages: [UIImage] = []
    var pageImages: [UIView] = [];
    var pageViews: [UIView?] = [];
    var selectedProduct = Product()
    
    var productsArray: Array<Product> = []
    
    private var itemHorta_CVC = ItemHorta_CollectionViewController()
    
    //---------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemHorta_CVC = ItemHorta_CollectionViewController( nibName: "ItemHorta_CollectionViewController", bundle: nil )
        self.itemHorta_CVC.updateInfoDelegate = self
        
        /** SIMULAÇÃO DE PRODUTOS NA HORTA */
//        let product1 = Product()
//        let product2 = Product()
//        let product3 = Product()
//        let product4 = Product()
//        let product5 = Product()
//        let product6 = Product()
//        
//        product1.photo = "batata.png"
//        product2.photo = "cebola.png"
//        product3.photo = "cenoura.png"
//        product4.photo = "alface.png"
//        product5.photo = "brocolis"
//        product6.photo = "abobora"
//        
//        product1.name = "batata"
//        product2.name = "cebola"
//        product3.name = "cenoura"
//        product4.name = "alface"
//        product5.name = "brocolis"
//        product6.name = "abobora"
//        
//        product1.description = "Batata"
//        product2.description = "Cebola"
//        product3.description = "Cenoura"
//        product4.description = "Alface"
//        product5.description = "Brócolis"
//        product6.description = "Abóbora"
//
//        self.productsArray.append( product1 )
//        self.productsArray.append( product2 )
//        self.productsArray.append( product3 )
//        self.productsArray.append( product4 )
//        self.productsArray.append( product5 )
//        self.productsArray.append( product6 )
        /** FIM DA SIMULAÇÃO */
        
        self.itemHorta_CVC.productsArray = self.productsArray
        self.itemHortaContainer.addSubview( self.itemHorta_CVC.view )
    }
    
    //---------------------------------------------------------------------------
    func updateInfoOnDisplay( product: Product ) {
        
        self.imgView.image = UIImage( named: product.photo! )
        self.nomeItem.text = product.description
        self.selectedProduct = product
    }
    
    //----------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //---------------------------------------------------------------------------
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        
        if segue.identifier == "AdicionarProduto" {
            if let vc = segue.destinationViewController as? AdicionarProduto {
                vc.productArray = self.productsArray
            }
        }
    }

    //---------------------------------------------------------------------------
    @IBAction func deletarProduto() {
        
        var i: Int = 0
        
        for p in self.productsArray {
            if self.selectedProduct.recordID == p.recordID {
                
                self.productsArray.removeAtIndex( i )
                self.itemHorta_CVC.productsArray = self.productsArray
                self.itemHorta_CVC.collection.reloadData()
                
                if self.productsArray.count > 0 {
                    let product = self.productsArray[ 0 ]
                    self.updateInfoOnDisplay( product )
                }
                else {
                    self.imgView.image = nil
                }
                
                return
            }
    
            i += 1
        }
    }
    
    //---------------------------------------------------------------------------
}
//---------------------------------------------------------------------------
