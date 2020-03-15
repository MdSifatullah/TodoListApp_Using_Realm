//
//  MainViewController.swift
//  TodoListApp
//
//  Created by Md Sifat on 3/4/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import RealmSwift

class CatagoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var catagories : Results<Catagory>? = nil
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        catagories = realm.objects(Catagory.self)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.frame = CGRect(x: 8, y: 8, width: 36, height: 36)
        cell.imageView?.image = UIImage(named: "\(catagories![indexPath.row].icon)")
        cell.textLabel?.text = "\(catagories![indexPath.row].name) [\(catagories![indexPath.row].tasks.count)]"
        
        return cell
    }
    
    // Override to support editing the table view.
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            do {
    //                try realm.write {
    //                    let tasks = catagories![indexPath.row].tasks
    //                    realm.delete(tasks)
    //                    realm.delete(catagories![indexPath.row])
    //                    self.viewWillAppear(true)
    //                }
    //            } catch  {
    //                print("Error deleting Catagory")
    //            }
    //        }
    //    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = nil
        self.index = indexPath.row
        
        performSegue(withIdentifier: "CatagoryToTaskLists", sender: self)
        print("hi")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            if segue.identifier == "CatagoryToTaskLists"{
                let taskVC = segue.destination as! TasksListsTableViewController
                taskVC.catagory = catagories![index ?? 1]
                print("selectedIndex)")
            }
        
    }
    
    
}
