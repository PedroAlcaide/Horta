//
//  ItemHorta_CollectionViewController.swift
//  Horta
//
//  Created by Felipe R. de Luca on 10/29/15.
//  Copyright © 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

//----------------------------------------------------------------------
private let reuseIdentifier = "ItemHorta_CollectionViewCell"

class ItemHorta_CollectionViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UpdateItemDisplayDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var productsArray: Array<Product> = []
    
    var updateInfoDelegate: UpdateItemDisplayDelegate?
    
    //----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collection?.delegate = self
        self.collection?.dataSource = self
        
        let cellNib = UINib( nibName: reuseIdentifier, bundle: nil )
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collection?.registerNib( cellNib, forCellWithReuseIdentifier: reuseIdentifier )
        
        self.collection?.reloadData()
        // Do any additional setup after loading the view.
    }

    //----------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //----------------------------------------------------------------------
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    //----------------------------------------------------------------------
    func updateInfoOnDisplay( product: Product ) {
        
        self.updateInfoDelegate?.updateInfoOnDisplay( product )
    }

    //----------------------------------------------------------------------
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //----------------------------------------------------------------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        return self.productsArray.count
    }

    //----------------------------------------------------------------------
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ItemHorta_CollectionViewCell
        
        let product = self.productsArray[ indexPath.row ]
        
        cell.product = product
        cell.productImg.image = UIImage( named: product.photo! )
        cell.updateInfoDelegate = self
        
        // Configure the cell
    
        return cell
    }

    //----------------------------------------------------------------------
    func ownDidLayoutSubviews (){
        
        let frame = self.view.frame
        self.collection!.frame = CGRectMake(frame.origin.x + 16, frame.origin.y+16, frame.size.width - 32, frame.size.height - 175)
    }
    
    //-------------------------------------------------------------------------------------------
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
        return CGSize(width: 107, height: 143) // The size of one cell
    }
    
    //----------------------------------------------------------------------

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
//----------------------------------------------------------------------
