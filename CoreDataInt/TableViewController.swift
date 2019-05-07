//
//  ViewController.swift
//  CoreDataInt
//
//  Created by Vu on 5/7/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var data: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchObject()
    }
    

    func fetchObject() {
        if let data = try? AppDelegate.context.fetch(Entity.fetchRequest()) as [Entity] {
            self.data = data.map{ Int($0.int)}
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(data[indexPath.row])
        return cell
    }
    @IBAction func addMore(_ sender: UIBarButtonItem) {
        showAlert(titlt: "Add More", message: "Do Something") { alert in
            if let content = alert.textFields?.first?.text {
                var entity = Entity(context: AppDelegate.context)
                entity.int = Int16(content) ?? 0
                AppDelegate.saveContext()
                self.fetchObject()
            }
        }
    }
    

}

func showAlert(titlt: String, message: String, completHander: ((UIAlertController) -> Void)? = nil) {
    let alertController = UIAlertController(title: titlt, message: message, preferredStyle: .alert)
    alertController.addTextField { textField in
        textField.placeholder = "Write here!!!"
    }
    let okAlert = UIAlertAction(title: "Ok", style: .cancel) { result in
        completHander?(alertController)
    }
    alertController.addAction(okAlert)
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        rootVC.present(alertController, animated: true, completion: nil)
    }
}
