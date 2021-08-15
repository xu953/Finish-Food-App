//
//  Frozen_food.swift
//  FinishFood
//
//  Created by Zhenyu Xu on 8/7/21.
//

import UIKit

class Frozen_food: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    // Create a variable to store entered information
    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use UserDefaults to store the items
        self.data = UserDefaults.standard.stringArray(forKey: "frozen_items") ?? []
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    // Functions for the tableview to perform actions in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Pop up window when click the item (needs update)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.data.remove(at: indexPath.row)
            UserDefaults.standard.setValue(self.data, forKey:"frozen_items")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    // Use alert pop up window to allow user adding new items
    @IBAction func didTapAddButton(){
        let alert = UIAlertController(title: "New Item", message: "Add frozen food", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter item name and today's date"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_)in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    DispatchQueue.main.async{
                        //var currentItems = UserDefaults.standard.stringArray(forKey: "frozen_items") ?? []
                        //currentItems.append(text)
                        self.data.append(text)
                        self.table.reloadData()
                        UserDefaults.standard.setValue(self.data, forKey:"frozen_items")
                    }
                }
            }
        }))
        present(alert, animated: true)

    }
    
    
}

