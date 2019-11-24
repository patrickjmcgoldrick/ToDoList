//
//  DataController.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

public protocol DataControllerPC {
    
    // write task
    func addTask(task: ToDoTask)
    
    // read pending tasks
    func getPendingTasks() -> [ToDoTask]
    
    // read complted tasks
    func getCompletedTasks() -> [ToDoTask]
    
}
