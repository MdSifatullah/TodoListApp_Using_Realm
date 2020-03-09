//
//  AddCatagoryViewController.swift
//  TodoListApp
//
//  Created by Md Sifat on 3/8/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import RealmSwift

class AddCatagoryTableViewController: UITableViewController, UITextFieldDelegate, IconPickerViewDelegate {
    let realm = try! Realm()
    var iconName = "folder"
    
    
    @IBOutlet weak var catagoryNameTxtField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImageView.image = UIImage(named: iconName)
        
    }
    
    func iconPicker(_ picker: AddIconTableViewController, didPick iconName: String){
        iconImageView.image = UIImage(named: iconName)
        self.iconName = iconName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        catagoryNameTxtField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = catagoryNameTxtField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
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
    
    @IBAction func DoneOnClick(_ sender: Any) {
        let catagory = Catagory()
        catagory.id = IncrementID()
        catagory.name = catagoryNameTxtField.text!
        catagory.icon = iconName
        
        do {
            try self.realm.write {
                realm.add(catagory)
                print("Success \(catagory)")
            }
        } catch  {
            print("Error")
        }
        
        navigationController?.popViewController(animated: true)
    }
    func IncrementID()-> Int{
        let id = (realm.objects(Catagory.self).max(ofProperty: "id") as Int? ?? 0) + 1
        return id
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 1 ? indexPath: nil
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            performSegue(withIdentifier: "ConcatIcon", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConcatIcon"{
            let vc = segue.destination as! AddIconTableViewController
            vc.delegate = self
        }
    }
    
    
}
