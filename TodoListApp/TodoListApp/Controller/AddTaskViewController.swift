//
//  AddTaskViewController.swift
//  TodoListApp
//
//  Created by Md Sifat on 3/9/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    var catagory : Catagory?
    var reminder = false
    var date = Date()
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var dateShowLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTaskTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd hh:mm"
        reminderSwitch.isOn = false
        datePickerView.isHidden = true
        dateShowLabel.text = dateFormatter.string(from: date)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = newTaskTextField.text!
        let strRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: strRange, with: string)
        
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
    
    @IBAction func doneOnClickBtn(_ sender: Any) {
        let id = IncrementID()
        ScheduleNitification(id: id)
        
        
        do{
            try realm.write{
                if let subCatagory = catagory{
                    let task = Task()
                    task.name = newTaskTextField.text!
                    task.id = id
                    subCatagory.tasks.append(task)
                    print("Success")
                }
            }
        }catch{
            print("error")
        }
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func reminderSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true{
            datePickerView.isHidden = false
            reminder = true
        }else{
            datePickerView.isHidden = true
            reminder = false
        }
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd hh:mm"
        dateShowLabel.text = dateFormatter.string(from: date)
        date = sender.date
    }
    
    func ScheduleNitification(id: Int){
        if reminder && date > Date(){
            let contex = UNMutableNotificationContent()
            contex.title = "Hey!! You have a task to Complete"
            contex.body = newTaskTextField.text!
            contex.sound = UNNotificationSound.default
            
            let calender = Calendar(identifier: .gregorian)
            let components = calender.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "task-\(id)", content: contex, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
        }
        
    }
    
    func IncrementID() -> Int{
        let id = (realm.objects(Task.self).max(ofProperty: "id") as Int? ?? 0) + 1
        return id
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
