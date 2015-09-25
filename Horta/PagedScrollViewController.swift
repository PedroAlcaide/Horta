//
//  PagedScrollViewController.swift
//  Horta
//
//  Created by Pedro Alcaide on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class PagedScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var gardenController = GardenController.sharedInstance;
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var lblIDCanteiro: UILabel!;
    @IBOutlet var imgView: UIImageView!;
    @IBOutlet var nomeResponsavel: UILabel!;
    @IBOutlet var nomeItem: UILabel!;
    
   // var pageImages: [UIImage] = []
    var pageImages: [UIView] = [];
    var pageViews: [UIView?] = [];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        // 1
//        pageImages = [UIImage(named: "batata.png")!,
//            UIImage(named: "alface.png")!,
//            UIImage(named: "cebola.png")!,
//            UIImage(named: "cenoura.png")!,
//            UIImage(named: "alface.png")!]

        gardenController.linkCanteiroIDWithUI( lblIDCanteiro ); // Conecta o componente da tela com o código
        gardenController.linkItemImageWithUI( imgView ); // Conecta o componente da tela com o código
        gardenController.linkNomeResponsavelWithUI( nomeResponsavel );
        gardenController.linkNomeItemWithUI( nomeItem );
        
        for i in 0...3 {
            let img = UIImage( named: "cebola" );
            gardenController.addItem( idCanteiro: i, imgItem: img! );
//            var item = NSBundle.mainBundle().loadNibNamed("layout_item_horta", owner: self, options: nil )[0] as! layout_item_horta;
            //item.setTextLabelIDCanteiro( "#" + String(i + 1) );
           // pageImages.append( item );
        }
        
        // Carrega os itens da horta
        let itens = gardenController.getItens();
        for i in itens {
            pageImages.append( i );
        }
        
        // Altera as imagens
        gardenController.setItemImg( id: 1, img: UIImage( named:"alface")! );
        gardenController.setItemImg( id: 2, img: UIImage( named:"batata")! );
        gardenController.setItemImg( id: 3, img: UIImage( named:"cenoura")! );
        
        gardenController.setNomeResponsavel(id: 0, nome: "Alessandra" );
        gardenController.setNomeResponsavel(id: 1, nome: "João" );
        gardenController.setNomeResponsavel(id: 2, nome: "Adamastor" );
        gardenController.setNomeResponsavel(id: 3, nome: "Janaína" );

        gardenController.setNomeItem(id: 0, nome: "cebola");
        gardenController.setNomeItem(id: 1, nome: "alface");
        gardenController.setNomeItem(id: 2, nome: "batata");
        gardenController.setNomeItem(id: 3, nome: "cenoura");
        
        gardenController.updateInfo( 0 );
        let pageCount = pageImages.count
        
        // 2
        pageControl.currentPage = 1
        pageControl.numberOfPages = pageCount
        
        // 3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // 4
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
            height: pagesScrollViewSize.height)
        
        // 5
        loadVisiblePages()
    }
    //---------------------------------------------------------------------------
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        pageControl.currentPage = page
        
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    //---------------------------------------------------------------------------
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Load an individual page, first checking if you've already loaded it
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page);
            frame.origin.y = 0.0
            frame = CGRectInset(frame, 10.0, 0.0)
            
            //let newPageView = UIImageView(image: pageImages[page])
            let newPageView: UIView = UIView();
            newPageView.addSubview(pageImages[page]);
          //  newPageView.contentMode =
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }
    //---------------------------------------------------------------------------
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    //---------------------------------------------------------------------------
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    // Do any additional setup after loading the view.
    //---------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
