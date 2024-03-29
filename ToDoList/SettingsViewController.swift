//
//  SettingsViewController.swift
//  ToDoList
//
//  Created by dirtbag on 11/25/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private var segDataSource: UISegmentedControl!

    var dataStoreIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load stored values
        dataStoreIndex = UserDefaults.standard.integer(forKey: K.Key.dataSourceIndexKey)

        segDataSource.selectedSegmentIndex = dataStoreIndex
    }

    @IBAction private func segChangeDataSource(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        switch segDataSource.selectedSegmentIndex {
        case 0:
            appDelegate?.dataController = ArchiverDataController()

        case 1:
            appDelegate?.dataController = CoreDataController.sharedManager

        default: break
        // nothing here
        }

        UserDefaults.standard.set(segDataSource.selectedSegmentIndex, forKey: K.Key.dataSourceIndexKey)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
