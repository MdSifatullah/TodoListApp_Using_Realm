//
//  AddIconTableViewController.swift
//  TodoListApp
//
//  Created by Md Sifat on 3/8/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit

protocol IconPickerViewDelegate : class{
    func iconPicker (_ picker: AddIconTableViewController, didPick iconName: String)
}

class AddIconTableViewController: UITableViewController {
    let icons = ["calender","drink","flight","folder","meeting","photo","shopping","movie","bag","cake","gift"]
    var delegate : IconPickerViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return icons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        cell.textLabel?.text = icons[indexPath.row]
        cell.imageView?.image = UIImage(named: icons[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.iconPicker(self, didPick: icons[indexPath.row])
            navigationController?.popViewController(animated: true)
        }
    }
}
