//
//  MyAppointmentsViewController.swift
//  The Friendly Gardener App
//
//  Created by Cristhiam Teran on 11/08/22.
//

import UIKit

class MyAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items : [Appointment]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var gardenName: NSLayoutConstraint!
    @IBOutlet weak var gardenArea: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchItems()
    }
    
    @IBAction func addItem_tap(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "AppointmentInfoViewController") as? AppointmentInfoViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let item = self.items![indexPath.row]
        var label = item.gardenName! + " on " + item.date! + " at " + item.time!
        cell.textLabel?.text = label
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let itemToRemove = self.items![indexPath.row]
            
            self.context.delete(itemToRemove)
            
            do {
                try self.context.save()
            }
            catch {
                print("Error when deleting item")
            }
            
            self.fetchItems()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items![indexPath.row]
        
        /*if let vc = storyboard?.instantiateViewController(identifier: "GardenInfoViewController") as? GardenInfoViewController {
         vc.garden = item
         self.navigationController?.pushViewController(vc, animated: true)
         }*/
    }
    
    func fetchItems() {
        do {
            self.items = try context.fetch(Appointment.fetchRequest())
            
            DispatchQueue.main.async {
                self.itemsTableView.reloadData()
            }
        }
        catch {
            print("Error when fetching data")
        }
    }
    
}
