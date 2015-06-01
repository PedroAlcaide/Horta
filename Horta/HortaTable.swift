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
    
    
    
    override func viewDidLoad() {
        self.table.delegate = self
        self.table.dataSource = self
        
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
