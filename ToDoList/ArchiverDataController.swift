//
//  ArchiverDataController.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

class ArchiverDataController : DataControllerPC {
    
    private static let ARCHIVE_FILENAME : String = "tasks_archive"
    
    func addTask(task: ToDoTask) {
        
        var tasks = getAllTasks()
        tasks.append(task)
        
        if saveObject(fileName: ArchiverDataController.ARCHIVE_FILENAME, object: tasks) {
            print ("Save worked...")
        } else {
            print ("Save failed>")
        }
        
    }
    
    func getCompletedTasks() -> [ToDoTask] {
        return getAllTasks()
    }
    
    func getPendingTasks() -> [ToDoTask] {
        return getAllTasks()
    }
    
    private func getAllTasks() -> [ToDoTask] {
        
        let result = getObject(fileName: ArchiverDataController.ARCHIVE_FILENAME) as? [ToDoTask]
        
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
        
        print ("File Path: \(filePath)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            print ("Created Data Object.")
            
            try data.write(to: filePath)
            
            print ("Wrote file to disk")
            return true
        } catch {
            print("error is: \(error.localizedDescription)")//4
        }
        return false
    }
    
    // Get object from document directory
    private func getObject(fileName: String) -> Any? {
        
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)//5
        do {
            let data = try Data(contentsOf: filePath)//6
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)//7
            return object//8
        } catch {
            print("error is: \(error.localizedDescription)")//9
        }
        return nil
    }
    
    //Get the document directory path
    private func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
    
}
