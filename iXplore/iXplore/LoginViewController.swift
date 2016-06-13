//
//  LoginViewController.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-13.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // by default, register button should be inactive
        self.loginButton.userInteractionEnabled = false
        
        // Do any additional setup after loading the view.
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // store the non-edited text field inside a variable
        var otherTextField: UITextField!
        if textField.tag == 1 {
            otherTextField = self.emailField
        } else {
            otherTextField = self.passwordField
        }
        
        // store the edited text field's future value in a variable
        var futureString: String!
        if string == "" {
            futureString = textField.text!
            futureString = futureString.substringToIndex(futureString.endIndex.predecessor())
        } else {
            futureString = textField.text! + string
        }
        
        // now check if both text fields are empty
        if (futureString == "") || (otherTextField.text! == "") {
            // textField is empty, register button should be inactive
            self.loginButton.userInteractionEnabled = false
        } else {
            self.loginButton.userInteractionEnabled = true
        }
        
        return true
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        // if login worked, navigate to the main screen
        if UserController.sharedInstance.loginUser(withUsername: self.emailField.text!, andPassword: self.passwordField.text!).0 {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToMainController()
        }
    }

}
