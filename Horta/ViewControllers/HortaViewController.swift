//
//  HortaViewController.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 09/11/15.
//  Copyright © 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class HortaDetailsViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBairro: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnBack: UIButton!
    
    var garden : Garden?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblName.text = self.garden?.name
        self.lblBairro.text = self.garden?.district
        self.txtView.text = self.garden?.address
        self.txtDescription.text = self.garden?.description

        // Do any additional setup after loading the view.
    }

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

    @IBAction func back(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
