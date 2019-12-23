//
//  ToDoTask.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

public class ToDoTask: NSObject, NSCoding {
    private static var idCount: Int32 = 0

    public static func getNextId() -> Int32 {
        let count = idCount
        idCount += 1
        return count
    }

    var id: Int32
    var createdDate = Date()
    var dueDate: Date
    var title: String
    var desc: String
    var completed: Bool = false
    var completedDate: Date?

    // our encoder
    public func encode(with aCoder: NSCoder) {
        print("Calling Encode - todoId is: \(id)")

        aCoder.encodeCInt(id, forKey: "id")
        aCoder.encode(createdDate, forKey: "createdDate")
        aCoder.encode(dueDate, forKey: "dueDate")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(completed, forKey: "completed")
        aCoder.encode(completedDate, forKey: "completedDate")
    }

    // our decoder
    public required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeCInt(forKey: "id")
        print("decoded id to: \(self.id)")

        self.createdDate = (aDecoder.decodeObject(forKey: "createdDate") as? Date)!
        self.dueDate = (aDecoder.decodeObject(forKey: "dueDate") as? Date)!
         self.title = (aDecoder.decodeObject(forKey: "title") as? String)!
        self.desc = (aDecoder.decodeObject(forKey: "desc") as? String)!
        self.completed = aDecoder.decodeBool(forKey: "completed")
        self.completedDate = aDecoder.decodeObject(forKey: "completedDate") as? Date
    }

    // constructor
    public init(dueDate: Date, title: String, desc: String) {
        print("Id: \(ToDoTask.idCount)")

        self.id = ToDoTask.getNextId()

        self.createdDate = Date()
        self.dueDate = dueDate
        self.title = title
        self.desc = desc
        self.completed = false
        self.completedDate = nil
    }

    // full constructor
    public init(createdDate: Date, dueDate: Date, title: String, desc: String, completed: Bool, completedDate: Date?) {
        self.id = 0

        self.createdDate = createdDate
        self.dueDate = dueDate
        self.title = title
        self.desc = desc
        self.completed = completed
        self.completedDate = completedDate
    }
}
