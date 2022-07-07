//
//  ViewController.swift
//  Evaluation1
//
//  Created by Student11 on 07/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var bienvenue: UILabel!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var inscription: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var switchToggle: UISwitch!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        login.delegate = self
        password.delegate = self
        
        
        

    
    
    
    let tapOnView = UITapGestureRecognizer(target: view, action:
    #selector(UIView.endEditing))
    view.addGestureRecognizer(tapOnView)
    
    }
    
    @IBAction func newsletterOk() {
        if switchToggle.isOn == true {
            inscription.text = "vous êtes inscrit à la newsletter"
        } else {
            inscription.text = "souhaitez vous vous abonner? "
        }
    }
    
    @IBAction func passHidden() {
        if password.isSecureTextEntry == true  {
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            password.isSecureTextEntry = false
        } else {
            eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            password.isSecureTextEntry = true
        }
    }
    
    @IBAction func tapOnLog() {
        
        var title = ""
        var message = ""
        var alertButt = ""
        var alertButt2 = ""
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
               
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    
        if predicate.evaluate(with: login.text) || (password.text?.count ?? 0 > 3 ){
            
            if !predicate.evaluate(with: login.text){
                title = "ERREUR"
                message = "votre email est invalide"
                alertButt = "ok"
                
            } else if !(password.text?.count ?? 0 > 3 ){
                title = "ERREUR"
                message = "votre password fait moins de 4 caractères"
                alertButt = "ok"

                
            } else {
                title = "Bienvenue \(login.text!)"
                if switchToggle.isOn {
                    message = "vous etes bien inscrit à notre newsletter"
                    alertButt = "merci"
                } else {
                    message = "souhaitez vous vous abonnez à notre newsletter?"
                    alertButt = "non merci"
                    alertButt2 = "m'abonner"
                }
            }
        }
            else {
                title = "ERREUR"
                message = "veillez remplir votre mdp et votre login"
                alertButt = "ok"
            }
            
            
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if alert.title == "ERREUR" {
            alert.addAction((UIAlertAction(title: alertButt, style: .cancel)))
        } else {
            if switchToggle.isOn {
            alert.addAction((UIAlertAction(title: alertButt, style: .cancel)))
            
            
            } else {
                alert.addAction(UIAlertAction(title: alertButt, style: .default))
                
                alert.addAction((UIAlertAction(title: alertButt2, style: .cancel, handler: { _ in self.switchToggle.isOn = true })))
                
            }
        }
        
        
        present(alert, animated: true, completion: nil)
    }
 
    

    override func viewDidAppear(_ animated: Bool) {
        userImg.layer.cornerRadius = userImg.frame.width / 2
    }
    
    

}

extension ViewController : UITextFieldDelegate {
    
    

    func textFieldShouldReturn ( _ textField: UITextField) -> Bool {
        var reset = false

        if textField == login {
            reset = password.becomeFirstResponder()
        } else {
            reset = view.endEditing(true)
            
            


            
        }

        return reset
    }
}



