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
    
    struct Property {
        let propertyImage: String
        let propertyAddress: String
        let properyArea: String
    }
    
    // Dummy Data
    let data: [Property] = [
        Property(propertyImage: "backyard1", propertyAddress: "256, Lester Street, Waterloo, ON, N2L 0K3", properyArea: "300"),
        Property(propertyImage: "backyard2", propertyAddress: "258B, Sunview Street, Waterloo, ON, N2L 0K3", properyArea: "200"),
        Property(propertyImage: "backyard1", propertyAddress: "130-9, Columbia Street, Waterloo, ON, N2L 0K3", properyArea: "500")
    ]

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
        cell.propertyImage.image = UIImage(named: appointment.propertyImage)
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
        selectedPropertyImage = data[indexPath1.row].propertyImage
        selectedPropertyArea = data[indexPath1.row].properyArea
        
        let selectedAppointment:AppointmentDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetailViewController") as! AppointmentDetailViewController
        
        self.navigationController?.pushViewController(selectedAppointment, animated: true)
    }

}
