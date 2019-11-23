//
//  ViewController.swift
//  ToDoList
//
//  Created by dirtbag on 11/22/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class PendingTasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension PendingTasksViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingCell", for: indexPath) as! PendingTaskCell
        
        return cell
    }
    

}

extension PendingTasksViewController : UITableViewDelegate {
    
    // to turn on row deletion action
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            print ("Deleting rowAt: \(indexPath.row)")
        }
    }
}
