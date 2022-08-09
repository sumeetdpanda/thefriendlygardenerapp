//
//  AppointmentDetailViewController.swift
//  The Friendly Gardener App
//
//  Created by Sumeet Shrivastava on 2022-08-09.
//

import UIKit

var selectedPropertyAddress = ""
var selectedPropertyImage = ""
var selectedPropertyArea = ""
var selectedPropertyDescription = ""

class AppointmentDetailViewController: UIViewController {

    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var propertyArea: UILabel!
    @IBOutlet weak var propertyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        propertyAddress.text = selectedPropertyAddress
        propertyArea.text = selectedPropertyArea
        propertyImage.image = UIImage(named: selectedPropertyImage)
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
