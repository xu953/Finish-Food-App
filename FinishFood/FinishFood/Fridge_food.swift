//
//  Fridge_food.swift
//  FinishFood
//
//  Created by Zhenyu Xu on 8/7/21.
//

import UIKit

class Fridge_food: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.data = UserDefaults.standard.stringArray(forKey: "fridge_items") ?? []
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
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
            UserDefaults.standard.setValue(self.data, forKey:"fridge_items")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    @IBAction func didTapAddButton(){
        let alert = UIAlertController(title: "New Item", message: "Add fridge food", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter item name and today's date"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_)in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    DispatchQueue.main.async{
                        //var currentItems = UserDefaults.standard.stringArray(forKey: "fridge_items") ?? []
                        //currentItems.append(text)
                        self.data.append(text)
                        self.table.reloadData()
                        UserDefaults.standard.setValue(self.data, forKey:"fridge_items")
                    }
                }
            }
        }))
        present(alert, animated: true)

    }
    
    
}


