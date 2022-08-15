//
//  ChooseAppointmentViewController.swift
//  The Friendly Gardener App
//
//  Created by Sumeet Shrivastava on 2022-08-09.
//

import UIKit

var rowGlobal = 0

class ChooseAppointmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    struct Property {
        let propertyAddress: String
        let properyArea: String
    }
    
    // Dummy Data
    var data: [Property] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        table.dataSource = self
        table.delegate = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = data[indexPath.row]
        rowGlobal = indexPath.row
        let cell = table.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! ChooseAppointmentTableViewCell
        cell.propertyAddress.text = appointment.propertyAddress
        cell.propertyArea.text = appointment.properyArea
        cell.selectionButton.tag = indexPath.row
        cell.selectionButton.addTarget(self, action: #selector(selectionButton), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    @objc func selectionButton(sender:UIButton)
    {
        let indexPath1 = IndexPath(row: sender.tag, section: 0)
        selectedPropertyAddress = data[indexPath1.row].propertyAddress
        selectedPropertyArea = data[indexPath1.row].properyArea
        
        let selectedAppointment:AppointmentDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetailViewController") as! AppointmentDetailViewController
        
        self.navigationController?.pushViewController(selectedAppointment, animated: true)
    }
    
    func loadData(){
        do{
            let dbData = try context.fetch(Appointment.fetchRequest())
            
            for appointment in dbData{
                data.append(Property(propertyAddress: appointment.address!, properyArea: appointment.area!))
            }
            
        } catch{
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
    }

}
