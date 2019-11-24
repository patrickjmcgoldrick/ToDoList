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
    
    @IBOutlet weak var lblErrorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblErrorMsg.text = ""
        
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
    
    // react to either button being clicked
    @IBAction func btnActionDone(_ sender: Any) {
        
        if tfTitle.text == "" {
            
            setError(message: "Please enter a title.")
            return
        }
        
        if tfDescription.text == "" {
            
            setError(message: "Please enter a Description.")
                return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataController = appDelegate.dataController
        
        let task = ToDoTask(dueDate: Date(),
                            title: tfTitle.text!,
                            desc: tfDescription.text)
        
        print ("Saving Task.")
        
        if (dataController?.addTask(task: task) != nil) {
            print ("Saved!")
        } else {
            print ("Error saving Task")
        }
        
    }
    
    private func setError(message: String) {
        
        lblErrorMsg.text = message
        
    }
    
}
