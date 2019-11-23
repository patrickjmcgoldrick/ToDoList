//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    
    @IBOutlet weak var tfDescription: UITextView!
    
    @IBOutlet weak var tfDueDate: UITextField!
    
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDueDatePicker()
    
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /**
     * Configure Date Picker
     */
    func setupDueDatePicker() {
        
        // default to Today's Date
        tfDueDate.text = Date().formatDueDate()
        
        // create picker
        datePicker = UIDatePicker()
         
        datePicker?.datePickerMode = .date
        
        // wire picker to TextField
        tfDueDate.inputView = datePicker
        
        // wire callback
        datePicker?.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        
        // allow escape from Date Picker
        // without changing the date
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    // callback for DatePicker adjustments
    @objc func datePickerValueChanged(sender:UIDatePicker) {
         
        tfDueDate.text = sender.date.formatDueDate()
        
        view.endEditing(true)
    }
    
}
