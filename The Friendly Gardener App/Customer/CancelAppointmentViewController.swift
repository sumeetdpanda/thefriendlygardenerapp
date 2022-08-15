//
//  CancelAppointmentViewController.swift
//  The Friendly Gardener App
//
//  Created by Sumeet Shrivastava on 2022-08-14.
//

import UIKit

class CancelAppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var appointments:[Appointment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Work here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(appointments[indexPath.row].taken == 1){
            cell.textLabel?.text = appointments[indexPath.row].address! + " on " + appointments[indexPath.row].date! + " at " + appointments[indexPath.row].time!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do{
            let data = try context.fetch(Appointment.fetchRequest())
            for appointment in data{
                if(appointment.taken == 1){
                    appointments.append(appointment)
                }
            }
            
        } catch{
            let alert = UIAlertController(title: "Error", message: "Something went wrong, please try again in some time", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
        
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            self.appointments[indexPath.row].taken = 0
            do{
                try self.context.save()
            } catch{
                let alert = UIAlertController(title: "Error", message: "Something went wrong, please try again in some time", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                self.present(alert, animated: true)
            }
            self.appointments.remove(at: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
        
        delete.backgroundColor = .red
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }

}
