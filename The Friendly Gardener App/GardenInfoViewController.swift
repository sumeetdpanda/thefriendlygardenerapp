//
//  GardenInfoViewController.swift
//  The Friendly Gardener App
//
//  Created by Cristhiam Teran on 10/08/22.
//

import UIKit

class GardenInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if (garden != nil) {
            titleTextField.text = garden!.title
            areaTextField.text = garden!.area
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    
    var garden: Garden?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func sabeButton_tap(_ sender: Any) {
        let item = getItemToSave()
        
        item.title = titleTextField.text
        item.area = areaTextField.text! ?? ""
        
        do {
            try self.context.save()
        }
        catch {
            print("Error when saving item")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func getItemToSave() -> Garden {
        if (garden != nil) {
            return garden!
        }
        else {
            return Garden(context: self.context)
        }
        
    }
}
