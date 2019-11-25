//
//  ViewController.swift
//  ToDoList
//
//  Created by dirtbag on 11/22/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import BEMCheckBox

class PendingTasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pendingTasks = [ToDoTask]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPendingTasks()
    }
    
    func loadPendingTasks() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataController = appDelegate.dataController
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {

            if let tasks = dataController?.getPendingTasks() {

                self.pendingTasks = tasks
                
            }
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

}

extension PendingTasksViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingCell", for: indexPath) as! PendingTaskCell
        
        cell.lblTitle.text = pendingTasks[indexPath.row].title
        cell.lblDesc.text = pendingTasks[indexPath.row].desc
        cell.lblDate.text = "Due: \(pendingTasks[indexPath.row].dueDate.formatDueDate())"
        
        cell.ckbxCompleted.on = false
        cell.ckbxCompleted.tag = indexPath.row
        cell.ckbxCompleted.delegate = self
        
        if pendingTasks[indexPath.row].dueDate.startOfDay() < Date().startOfDay() {
            cell.lblDate.textColor = .red
            cell.ckbxCompleted.tintColor = .red

        } else {
            cell.lblDate.textColor = .black
            cell.ckbxCompleted.tintColor = .systemGreen
        }
        return cell
    }
    

}

extension PendingTasksViewController : UITableViewDelegate {
    
    // to turn on row deletion action
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let dataController = appDelegate.dataController
            
            // background the removing of row
            DispatchQueue.global(qos: .background).async {

                if let tasks = dataController?.remove(index: indexPath.row, pending: self.pendingTasks) {

                    self.pendingTasks = tasks
                    
                }
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension PendingTasksViewController : BEMCheckBoxDelegate {
    
    func animationDidStop(for bemCheckBox: BEMCheckBox) {
        
        let row = bemCheckBox.tag
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataController = appDelegate.dataController
                
        // background the removing of row
        DispatchQueue.global(qos: .background).async {

            if let tasks = dataController?.markCompleted(
                        index: row,
                        pending: self.pendingTasks) {

                self.pendingTasks = tasks
                
            }
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
 
 
    }

}
