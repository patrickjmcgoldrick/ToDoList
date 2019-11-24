//
//  PendingTaskCell.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class PendingTaskCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblDesc: UILabel!
    
    var indexPath : IndexPath?
    weak var delegate : PendingCellDelegate?
    
    @IBAction func btnActionComplete(_ sender: Any) {
        if let indexPath = indexPath,
            let delegate = delegate {
            
            delegate.taskCompleted(indexPath: indexPath)
            
        }
    }
    
}


