//
//  TasksListsTableViewController.swift
//  TodoListApp
//
//  Created by Md Sifat on 3/9/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import RealmSwift

class TasksListsTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var catagory : Catagory?
    var tasks : List<Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
       // self.navigationItem.title = catagory?.name
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if let all = catagory?.tasks{
//            tasks = all
//        }
//        self.tableView.reloadData()
//    }
//    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5 //tasks?.count ?? 0
    }
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
//        
//        cell.textLabel?.text = tasks![indexPath.row].name
//        cell.accessoryType = tasks![indexPath.row].isDone == true ? .checkmark : .none
//        
//        return cell
//    }
    
    
    @IBAction func addTaskBtn(_ sender: Any) {
        performSegue(withIdentifier: "newTaskAdd", sender: self)
    }
    
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //    }
    //
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete{
    //            do {
    //                try realm.delete(tasks![indexPath.row])
    //                self.viewWillAppear(true)
    //            } catch  {
    //                print("Error")
    //            }
    //        }
//}


 // MARK: - Navigation
 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "newTaskAdd" {
//        let vc = segue.destination as! AddTaskViewController
//        vc.catagory = self.catagory
//    }
// }


}
