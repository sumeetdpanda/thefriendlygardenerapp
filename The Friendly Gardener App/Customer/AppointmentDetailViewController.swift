//
//  AppointmentDetailViewController.swift
//  The Friendly Gardener App
//
//  Created by Sumeet Shrivastava on 2022-08-09.
//

import UIKit

var selectedPropertyAddress = ""
var selectedPropertyArea = ""
var selectedPropertyDescription = ""

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class AppointmentDetailViewController: UIViewController {

    @IBOutlet weak var reserveAppointmentButton: UIButton!
    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var propertyArea: UILabel!
    @IBOutlet weak var propertyNote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        propertyAddress.text = selectedPropertyAddress
        propertyArea.text = selectedPropertyArea
        
        reserveAppointmentButton.addTarget(self, action: #selector(reserveAppointmentButtonClicked), for: .touchUpInside)
    }
    
    func loadData(){
        do{
            let dbData = try context.fetch(Appointment.fetchRequest())
            
            for appointment in dbData{
                if(appointment.address == selectedPropertyAddress){
                    if(appointment.note != ""){
                        propertyNote.text = appointment.note
                    } else{
                        propertyNote.text = "No Note"
                    }
                }
            }
            
        } catch{
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
    }

    @IBAction func reserveAppointmentButtonClicked(_ sender: Any) {
        do{
            let dbData = try context.fetch(Appointment.fetchRequest())
            
            for appointment in dbData{
                if(appointment.address == selectedPropertyAddress){
                    appointment.taken = 1
                }
            }
            
            let alert = UIAlertController(title: "Success", message: "Appointment successfully reserved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {_ in
                _ = self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
            
        } catch{
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
