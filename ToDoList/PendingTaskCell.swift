//
//  PendingTaskCell.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import BEMCheckBox

class PendingTaskCell: UITableViewCell {

    @IBOutlet weak var ckbxCompleted: BEMCheckBox!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblDesc: UILabel!
            
}


