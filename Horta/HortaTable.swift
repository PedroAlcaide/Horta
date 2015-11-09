//
//  HortaTable.swift
//  Horta
//
//  Created by Pedro Alcaide on 29/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class HortaView: UIViewController, UITableViewDelegate, UITableViewDataSource, GardenManagerDelegate {
    
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var gardenManager : GardenManager?
    var user:User?
    var arrayGardens: NSMutableArray?
    var indiceVetor : Int?
    
    override func viewDidLoad() {
        self.arrayGardens = NSMutableArray()
        self.table.delegate = self
        self.table.dataSource = self
        
        self.segmentControl.setTitle("Participo", forSegmentAtIndex: 0)
        self.segmentControl.setTitle("Admin", forSegmentAtIndex: 1)
        
        self.gardenManager = GardenManager()
        self.gardenManager?.delegate = self
        self.user = UserManager().getUserLogged()
        self.changeViews(self.segmentControl)
    }
    
    
    @IBAction func changeViews(sender: AnyObject) {
        
        let id = self.user?.recordID
        
        if  self.segmentControl.selectedSegmentIndex == 1{
            
            self.gardenManager?.getGardenByUser(id!, isAdmin: true)
            
        }else{
            self.gardenManager?.getGardenByUser(id!, isAdmin: false)
        }
        
        //self.segmentControl.selectedSegmentIndex
        
        print("mudou view", terminator: "")
        
    }
    
    @IBAction func hortaTableBack(segue:UIStoryboardSegue){
        // METODO É CHAMADO APOS RETORNAR DA PROXIMA VIEW
        // AINDA SERA IMPLEMENTADO
        
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrayGardens?.count)!;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        //var cell = self.table.dequeueReusableCellWithIdentifier("CustomCell") as! UITableViewCell
        let garden = self.arrayGardens?.objectAtIndex(indexPath.row) as! Garden
       // cell.lblHorta.text = "Danado"
        cell.lblGardenName.text = garden.name
        cell.lblDistrict.text = garden.district
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.indiceVetor = indexPath.row
        self.performSegueWithIdentifier("SegueHortaDetails", sender: nil)
        
    }
    
    
    // METODOS GARDEN_MANAGER DELEGATE
    
    func errorThrowed(message:String){
        
       dispatch_async(dispatch_get_main_queue()) { () -> Void in
        
        var alert = UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        
        }
        
        
        
    }
    func gardenOperationSuccessfull(){
        print("chamou metodo sucesso")
    }
    func getGardensSucessful(arrayGardens:NSMutableArray){
        self.arrayGardens = arrayGardens
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.table.reloadData()
        })
        
        print("chamou metodo vetor")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SegueHortaDetails" {
            if let vc = segue.destinationViewController as? HortaDetailsViewController {
                vc.garden = self.arrayGardens?.objectAtIndex(indiceVetor!) as! Garden
            }
        }
        
        
    }
    
    
}
