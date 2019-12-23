//
//  ArchiverDataController.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

class ArchiverDataController: DataControllerDelegate {
    private static let archiveFilename: String = "tasks_archive"

    func addTask(task: ToDoTask) {
        var tasks = getAllTasks()
        tasks.append(task)

        if saveObject(fileName: ArchiverDataController.archiveFilename, object: tasks) {
        } else {
            // TODO: need to throw or pass back info
            print("add Task failed.")
        }
    }

    func remove(index: Int, pending: [ToDoTask]) -> [ToDoTask] {
        var result = pending
        result.remove(at: index)

        // add completed and pending tasks and save to disk
        let completedTasks = getCompletedTasks()
        result += completedTasks

        _ = saveObject(fileName: ArchiverDataController.archiveFilename, object: result)

        return getPendingTasks()
    }

    func markCompleted(index: Int, pending: [ToDoTask]) -> [ToDoTask] {
        pending[index].completed = true
        pending[index].completedDate = Date()

        let completedTasks = getCompletedTasks()
        let result = pending + completedTasks

        _ = saveObject(fileName: ArchiverDataController.archiveFilename, object: result)

        return getPendingTasks()
    }

    func getCompletedTasks() -> [ToDoTask] {
        let allTasks = getAllTasks()
        let completedTasks = allTasks.filter { $0.completed }
        return completedTasks
    }

    func getPendingTasks() -> [ToDoTask] {
        let allTasks = getAllTasks()
        let pendingTasks = allTasks.filter { $0.completed == false }
        return pendingTasks
    }

    private func getAllTasks() -> [ToDoTask] {
        let result = getObject(fileName: ArchiverDataController.archiveFilename) as? [ToDoTask]

        if let tasks = result {
            return tasks
        } else {
            // no tasks, give back empty array
            return [ToDoTask]()
        }
    }

    // Save object in document directory
    private func saveObject(fileName: String, object: Any) -> Bool {
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)

            try data.write(to: filePath)

            return true
        } catch {
            print("error is: \(error.localizedDescription)")//4
        }
        return false
    }

    // Get object from document directory
    private func getObject(fileName: String) -> Any? {
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: filePath)
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            return object
        } catch {
            print("error is: \(error.localizedDescription)")
        }
        return nil
    }

    //Get the document directory path
    private func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
}
