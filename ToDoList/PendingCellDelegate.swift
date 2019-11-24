//
//  PendingCellDelegate.swift
//  ToDoList
//
//  Created by dirtbag on 11/24/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

protocol PendingCellDelegate : AnyObject {
    func taskCompleted(indexPath: IndexPath)
}
