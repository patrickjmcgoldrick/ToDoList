//
//  CoreDataDataController.swift
//  ToDoList
//
//  Created by dirtbag on 11/24/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import CoreData
import Foundation

class CoreDataController: DataControllerDelegate {
    static let sharedManager = CoreDataController()

   
    // MARK: Protocol Methods
    func addTask(task: ToDoTask) {
        createToDoRecord(title: task.title, description: task.desc, dueDate: task.dueDate)
    }

    func remove(index: Int, pending: [ToDoTask]) -> [ToDoTask] {
        let task = pending[index]
        removeRecord(task: task)

        return getPendingTasks()
    }

    func markCompleted(index: Int, pending: [ToDoTask]) -> [ToDoTask] {
        let task = pending[index]
        markCompleted(task: task)

        return getPendingTasks()
    }

    func getPendingTasks() -> [ToDoTask] {
        let rows = getPendingRows()
        let results = convert(records: rows)

        return results
    }

    func getCompletedTasks() -> [ToDoTask] {
       let rows = getCompletedRows()
       let results = convert(records: rows)

       return results
    }

    
    // MARK: Setup Managed Object Context
    let managedObjectContext: NSManagedObjectContext

    private init(moc: NSManagedObjectContext) {
        self.managedObjectContext = moc
    }

    private convenience init?() {
        guard let modeURL = Bundle.main.url(forResource: "ToDoList", withExtension: "momd") else {
            return nil
        }

        guard let mom = NSManagedObjectModel(contentsOf: modeURL) else {
            return nil
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc

        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        let persistantStoreFileURL = urls[0].appendingPathComponent("ToDoList.sqlite")

        do {
            try psc.addPersistentStore(
                        ofType: NSSQLiteStoreType,
                        configurationName: nil,
                        at: persistantStoreFileURL, options: nil)
        } catch {
            assertionFailure("Error adding data-store.")
        }

        self.init(moc: moc)
    }

    /// create new Task
    private func createToDoRecord(title: String, description: String, dueDate: Date) {
        // create new record
        guard let record = NSEntityDescription
            .insertNewObject(forEntityName: "Task", into: self.managedObjectContext) as? Task else { return }

        record.createdDate = Date()
        record.dueDate = dueDate
        record.title = title
        record.desc = description
        record.completed = false
        record.completedDate = nil

        do {
            try self.managedObjectContext.save()
        } catch {
            assertionFailure("couldn't save objects.")
        }
    }

    /// get all recrods of incomplete Tasks (Pending)
    private func getPendingRows() -> [Task] {
        // lookup roster data
        let pendingFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

        pendingFetch.predicate = NSPredicate(format: "(completed == false)")

        let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: true)

        pendingFetch.sortDescriptors = [sortDescriptor]

        var fetchedData: [Task]!
        do {
            fetchedData = try self.managedObjectContext.fetch(pendingFetch) as? [Task]
        } catch {
            assertionFailure("Task fetch failed: \(error.localizedDescription)")
        }

        return fetchedData
    }

    /// get all recrods of completed Tasks
    private func getCompletedRows() -> [Task] {
        // lookup roster data
        let pendingFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

        pendingFetch.predicate = NSPredicate(format: "(completed == true)")

        let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: true)

        pendingFetch.sortDescriptors = [sortDescriptor]

        var fetchedData: [Task]!
        do {
            fetchedData = try self.managedObjectContext.fetch(pendingFetch) as? [Task]
        } catch {
            assertionFailure("Task fetch failed: \(error.localizedDescription)")
        }

        return fetchedData
    }

    /// remove a record based on Created Date matching this object
    private func removeRecord(task: ToDoTask) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

        request.predicate = NSPredicate(format: "(createdDate == %@)", task.createdDate as NSDate)

        request.returnsObjectsAsFaults = false

        do {
            let records = try self.managedObjectContext.fetch(request)

            if records.count > 0 {
                for record: Any in records {
                    guard let record = record as? NSManagedObject  else { continue }
                    self.managedObjectContext.delete(record as NSManagedObject)
                }
                try self.managedObjectContext.save()
            }
        } catch {}
    }

    ///  Mark a record Completed based on cmatching this object
    private func markCompleted(task: ToDoTask) {
        // lookup records with (likely) unque date ('createdDate)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

        request.predicate = NSPredicate(format: "(createdDate == %@)", task.createdDate as NSDate)

        request.returnsObjectsAsFaults = false

        var fetchedData: [Task]!
        do {
            fetchedData = try self.managedObjectContext.fetch(request) as? [Task]
        } catch {
            assertionFailure("Task fetch failed: \(error.localizedDescription)")
        }

        // update those records as completed
        do {
            if !fetchedData.isEmpty {
                for record in fetchedData {
                    record.setValue(true, forKey: "completed")
                    record.setValue(Date(), forKey: "completedDate")
                }
            }

            try self.managedObjectContext.save()
        } catch {}
    }

    /// Convert Task records into ToDoTask Objects
    private func convert(records: [Task]) -> [ToDoTask] {
        var toDoTasks = [ToDoTask]()

        for todo in records {
            let todoTask = ToDoTask(createdDate: todo.createdDate!, dueDate: todo.dueDate!, title: todo.title!, desc: todo.desc!, completed: todo.completed, completedDate: todo.completedDate)

            toDoTasks.append(todoTask)
        }

        return toDoTasks
    }
}
