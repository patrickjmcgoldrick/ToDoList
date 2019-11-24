//
//  CompletedTasksViewController.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class CompletedTasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var completedTasks = [ToDoTask]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCompletedTasks()
    }

    
    func loadCompletedTasks() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataController = appDelegate.dataController
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {

            if let tasks = dataController?.getCompletedTasks() {

                self.completedTasks = tasks
                
            }
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }


}

extension CompletedTasksViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedCell", for: indexPath) as! CompletedTaskCell
        
        cell.lblTitle.text = completedTasks[indexPath.row].title
        if let completedDate = completedTasks[indexPath.row].completedDate {
            
            cell.lblCompletedDate.text = "Completed: \(completedDate.formatDueDate())"
        }
        
        return cell
    }
    
}
