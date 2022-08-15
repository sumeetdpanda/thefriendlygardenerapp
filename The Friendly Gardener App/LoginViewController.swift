//
//  LoginViewController.swift
//  The Friendly Gardener App
//
//  Created by Sumeet Shrivastava on 2022-08-14.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var customerLoginButton: UIButton!
    @IBOutlet weak var gardenerLoginButton: UIButton!
    
    var email:String = ""
    var password:String = ""
    var errorValidate:String = ""
    
    var flag:Int = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //GardenerStoryBoard
        //CustomerStoryBoard
        customerLoginButton.addTarget(self, action: #selector(customerButtonClicked), for: .touchUpInside)
        gardenerLoginButton.addTarget(self, action: #selector(gardenerButtonClicked), for: .touchUpInside)
    }
    
    @objc func customerButtonClicked(){
        getData()
        let validated = validateData()
        
        if(validated){
            let story = UIStoryboard(name: "Main", bundle: nil)
            let controller = story.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true)
            
        }
        
    }
    
    @objc func gardenerButtonClicked(){
        getData()
        let validated = validateData()
        
        if(validated){
            let story = UIStoryboard(name: "Main", bundle: nil)
            let controller = story.instantiateViewController(withIdentifier: "GardenerViewController") as! GardenerViewController
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true)
            
        }
    }
    
    func validateData() -> Bool{
        
        var validated:Bool = false
        
        do{
            let data = try context.fetch(User.fetchRequest())
            
            for item in data{
                if(item.email == email){
                    if(item.password == password){
                        validated = true
                        errorValidate = ""
                    }
                    else{
                        errorValidate = "Password is incorrect"
                    }
                }else{
                    errorValidate = "Email is incorrect"
                }
            }
            
            if(errorValidate != ""){
                let alert = UIAlertController(title: "Error", message: errorValidate, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                present(alert, animated: true)
            }
        } catch{
            flag = 1
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
        
        return validated
    }
    
    
    func getData(){
        email = emailText.text!
        password = passwordText.text!
        
        var error:String = ""
        
        if(email == ""){
            error = "Please enter an email."
        }else{
            if (password == ""){
                error = "Please enter password."
            }
        }
        
        if(error != ""){
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alert, animated: true)
        }
    }
}
