//
//  LoginViewController.swift
//  Horario
//
//  Created by Ivan on 20/6/17.
//  Copyright © 2017 Talentum. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        if self.emailField.text == "" || self.passwordField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Introduce usuario o contraseña", preferredStyle: UIAlertControllerStyle.alert)
            
            let okey = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(okey)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                
                if error == nil {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Logged")
                    
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okey = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    alert.addAction(okey)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Registro", message: "Introduce usuario y contraseña", preferredStyle: UIAlertControllerStyle.alert)
        
        let guardar = UIAlertAction(title: "Guardar", style: UIAlertActionStyle.default) { (UIAlertAction) in
            let email = alert.textFields?[0].text
            let password = alert.textFields?[1].text
            
            Auth.auth().createUser(withEmail: email!, password: password!, completion: nil)
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
        }
        
        alert.addTextField { (textEmail: UITextField) in
            textEmail.placeholder = "Email"
        }
        
        alert.addTextField { (textPassword: UITextField) in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Password"
        }
        
        alert.addAction(guardar)
        alert.addAction(cancelar)
        
        self.present(alert, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
