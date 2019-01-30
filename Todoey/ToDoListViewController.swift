//
//  ViewController.swift
//  Todoey
//
//  Created by Ishwar Dixit on 30/01/19.
//  Copyright © 2019 Ishwar Dixit. All rights reserved.


import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    
   // to save the data into the user's default database know as SandBox
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // the statement written below may crash the app if in case the array in the sandbox cantnot be retieved
       // itemArray = defaults.array(forKey: "ToDoListItems") as! [String]
        // but this statement ensures the app should not crash
        if let item = defaults.array(forKey: "ToDoListItems") as? [String]{
            itemArray = item
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    
    
    
    @IBAction func addbuttonTapped(_ sender: Any) {
        
        var item = UITextField()
        
        let alert  = UIAlertController(title: "Add New Item Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("success")
           
            self.itemArray.append(item.text!)
            print(self.itemArray)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListItems")
           
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item here"
            item = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

