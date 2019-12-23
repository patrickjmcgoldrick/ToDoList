//
//  DataController.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

protocol DataControllerDelegate {
    // write task
    func addTask(task: ToDoTask)

    // remove a record based on index
    func remove(index: Int, pending: [ToDoTask]) -> [ToDoTask]

    // mark a row completed
    func markCompleted(index: Int, pending: [ToDoTask]) -> [ToDoTask]

    // read pending tasks
    func getPendingTasks() -> [ToDoTask]

    // read complted tasks
    func getCompletedTasks() -> [ToDoTask]
}
