//
//  HortaTable.swift
//  Horta
//
//  Created by Pedro Alcaide on 29/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class HortaView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var gardenManager : GardenManager?
    var user:User?
    
    override func viewDidLoad() {
        self.table.delegate = self
        self.table.dataSource = self
        
        self.segmentControl.setTitle("Participo", forSegmentAtIndex: 0)
        self.segmentControl.setTitle("Admin", forSegmentAtIndex: 1)
        
        self.gardenManager = GardenManager()
        self.user = UserManager().getUserLogged()
    }
    
    
    @IBAction func changeViews(sender: AnyObject) {
        
        if  self.segmentControl.selectedSegmentIndex == 1{
            var id = self.user?.recordID
            self.gardenManager?.getGardenByUser(id!, isAdmin: true)
            
        }
        
        //self.segmentControl.selectedSegmentIndex
        
        print("mudou view")
        
    }
    
    @IBAction func hortaTableBack(segue:UIStoryboardSegue){
        // METODO É CHAMADO APOS RETORNAR DA PROXIMA VIEW
        // AINDA SERA IMPLEMENTADO
        
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.table.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        //var cell = self.table.dequeueReusableCellWithIdentifier("CustomCell") as! UITableViewCell
        cell.lblHorta.text = "Danado"
        return cell
    }
    
}
