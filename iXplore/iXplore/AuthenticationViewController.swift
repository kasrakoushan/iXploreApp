//
//  AuthenticationViewController.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-13.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonTapped(sender: UIButton) {
        let lvc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(lvc, animated: true)
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        let rvc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(rvc, animated: true)
    }
}
