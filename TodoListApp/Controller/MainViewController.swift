//
//  ViewController.swift
//  TodoListApp
//
//  Created by Md Sifat on 1/1/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class MainViewController: UITableViewController {
    
    var relm : Realm!
    var toDoList : Results<TodoListItem>{
        get{
            return relm.objects(TodoListItem.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        relm = try! Realm()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = toDoList[indexPath.row]
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = toDoList[indexPath.row]
        
        try! self.relm.write ({
            item.done = !item.done
        })
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = toDoList[indexPath.row]
            
            try! self.relm.write({
                self.relm.delete(item)
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Todo List", message: "Create a New Todolist", preferredStyle: .alert)
        alert.addTextField { (UITextField) in
            
        }
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) -> Void in

            let todoListTxtField = (alert.textFields?.first)! as UITextField
            let todoList = TodoListItem()
            todoList.name = todoListTxtField.text!
            todoList.done = false

            try! self.relm.write ({
                self.relm.add(todoList)

                self.tableView.insertRows(at: [IndexPath.init(row: self.toDoList.count-1, section: 0)], with: .automatic)
            })

        }
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
}

