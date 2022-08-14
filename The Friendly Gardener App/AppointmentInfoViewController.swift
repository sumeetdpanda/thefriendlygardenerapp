//
//  AppointmentInfoViewController.swift
//  The Friendly Gardener App
//
//  Created by Cristhiam Teran on 11/08/22.
//

import UIKit

class AppointmentInfoViewController: UIViewController {

    @IBOutlet weak var gardenPopupButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var noteText: UITextView!
    
    var garden:String = ""
    var time:String = ""
    var date:String = ""
    var note:String = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Button Setup
        gardenPopupButton.layer.borderWidth = 1
        gardenPopupButton.layer.borderColor = UIColor.gray.cgColor
        gardenPopupButton.layer.cornerRadius = 10
        
        populateGardenPopupButton()
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        // Date
        datePicker.locale = .current
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(dateSelection), for: .valueChanged)
        
        //Time
        timePicker.locale = .current
        timePicker.date = Date()
        timePicker.addTarget(self, action: #selector(timeSelection), for: .valueChanged)
    }
    
    @objc func dateSelection(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let date = dateFormatter.string(from: datePicker.date)
        self.date = date
    }
    
    @objc func timeSelection(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        let time = dateFormatter.string(from: timePicker.date)
        self.time = time
    }
    
    func getGarden(action: UIAction){
        self.garden = action.title
    }
    
    func returnGardens(handler: @escaping UIActionHandler) -> [UIAction]{
        let gardens = getGardens()
        var returnGardens:[UIAction] = []
        var flag = 1
        
        for garden in gardens {
            if(flag == 1){
                returnGardens.append(UIAction(title: garden.title!, state: .on, handler: handler))
                flag += 1
            }
            else {
                returnGardens.append(UIAction(title: garden.title!, handler: handler))
            }
        }
        return returnGardens
    }
    
    
    func populateGardenPopupButton(){
        
        let optionClosure = {(action: UIAction) in self.getGarden(action: action)}
        gardenPopupButton.menu = UIMenu(children:returnGardens(handler: optionClosure))
        
        gardenPopupButton.showsMenuAsPrimaryAction = true
        gardenPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    @objc func confirmButtonTapped(){
        var error:String = ""
        if(garden != ""){
            if(date != ""){
                if(time != ""){
                    // Save data in CoreData
                    saveData(garden: garden, date: date, time: time, note: note)
                }else{
                    error = "Select a time"
                }
            }else{
                error = "Select a date"
            }
        }else{
            error = "Select a garden"
        }
        
        if(error != ""){
            let alert = UIAlertController(title: "Error", message: error+".", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
    // CoreData data management
    func getGardens() -> [Garden]{
        do{
            let gardens = try context.fetch(Garden.fetchRequest())
            return gardens
        } catch {
            return []
        }
    }
    
    //Core Data Save Data
    func saveData(garden: String, date: String, time: String, note:String? = nil){
        let newEntry = Appointment(context: context)
        //newEntry.gardenName = garden
        newEntry.date = date
        //newEntry.time = time
        newEntry.note = note
        
        do{
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Your Appointment has been created", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            _ = navigationController?.popViewController(animated: true)
        } catch{
            let alert = UIAlertController(title: "Error", message: "There was some error in saving data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

}
