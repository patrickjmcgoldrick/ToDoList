//
//  DataController.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

public protocol DataControllerPC {
    
    func addTask(task: ToDoTask)
    
    func getCompletedTasks() -> [ToDoTask]
    
    func getPendingTasks() -> [ToDoTask]
}
