//
//  SignupViewController.swift
//  The Friendly Gardener App
//
//  Created by Sumeet Shrivastava on 2022-08-14.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var cnfPasswordText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var name:String = ""
    var email:String = ""
    var password:String = ""
    var cnfPassword:String = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signupButton.addTarget(self, action: #selector(signupButtonClicked(sender:)), for: .touchUpInside)
    }
    
    @objc
    func signupButtonClicked(sender: UIButton!){
        name = nameText.text!
        email = emailText.text!
        password = passwordText.text!
        cnfPassword = cnfPasswordText.text!
        
        var error:String = ""
        
        if(name != ""){
            if(email != ""){
                if(password != "" && password.count > 8){
                    if(cnfPassword != "" && password == cnfPassword){
                        
                        // Save Data
                        saveData(name: name, email: email, password: password)
                        
                    }else{
                        error = "Passwords do not match."
                    }
                }else{
                    error = "Please insert a valid password."
                }
            }else{
                error = "Please insert an email."
            }
        }else{
            error = "Please insert a name."
        }
        
        if(error != ""){
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
    }
    
    func saveData(name:String, email:String, password:String){
        let item = User(context: context)
        item.name = name
        item.email = email
        item.password = password
        
        do{
            try context.save()
            let alert = UIAlertController(title: "Success", message: "User successfully registered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {_ in
                
                _ = self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
            
        } catch{
            let alert = UIAlertController(title: "Error", message: "Something went wrong, please contact the developer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, andler: {_ in
                
                _ = self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
        }
    }

}
