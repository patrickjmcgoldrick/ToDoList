//
//  PendingTaskCell.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import BEMCheckBox
import UIKit

class PendingTaskCell: UITableViewCell {
    @IBOutlet var ckbxCompleted: BEMCheckBox!

    @IBOutlet var lblTitle: UILabel!

    @IBOutlet var lblDate: UILabel!

    @IBOutlet var lblDesc: UILabel!
}
