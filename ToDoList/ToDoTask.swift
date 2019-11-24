//
//  ToDoTask.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

public class ToDoTask : NSObject, NSCoding {
    
    var createdDate : Date = Date()
    var dueDate : Date
    var title : String
    var desc: String
    var completed : Bool = false
    var completedDate : Date?
    
    // our encoder
    public func encode(with aCoder: NSCoder) {

        aCoder.encode(self.createdDate, forKey: "createdDate")
        aCoder.encode(dueDate, forKey: "dueDate")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(completed, forKey: "completed")
        aCoder.encode(completedDate, forKey: "completedDate")

    }

    // our decodeer
    public required init?(coder aDecoder: NSCoder) {
   
        self.createdDate = (aDecoder.decodeObject(forKey: "createdDate") as? Date)!
        self.dueDate = (aDecoder.decodeObject(forKey: "dueDate") as? Date)!
         self.title = (aDecoder.decodeObject(forKey: "title") as? String)!
        self.desc = (aDecoder.decodeObject(forKey: "desc") as? String)!
        self.completed = aDecoder.decodeBool(forKey: "completed")
        self.completedDate = aDecoder.decodeObject(forKey: "completedDate") as? Date ?? nil
        
    }
    
    // constructor
    init(createdDate: Date, dueDate: Date, title: String, desc: String, completed: Bool, completedDate: Date?) {
        
        self.createdDate = createdDate
        self.dueDate = dueDate
        self.title = title
        self.desc = desc
        self.completed = completed
        self.completedDate = completedDate
    }
}
