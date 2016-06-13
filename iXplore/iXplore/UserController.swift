//
//  UserController.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-13.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import Foundation


struct User {
    var username: String
    var password: String
}

class UserController {
    // singleton variable
    class var sharedInstance: UserController {
        struct Static {
            static var instance:UserController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = UserController()
        }
        return Static.instance!
    }
    
    var userList = [User]()
    var loggedInUser: User?
    
    
    func loginUser(withUsername username: String, andPassword password: String) -> (Bool, String?) {
        for user in self.userList {
            if (user.username == username && user.password == password) {
                // login was successful
                self.loggedInUser = user
                return (true, nil)
            }
        }
        // login was unsuccessful
        return (false, "login was unsuccessful")
    }
    
    func registerUser(withUsername username: String, andPassword password: String) -> (Bool, String?) {
        for user in self.userList {
            if (user.username == username) {
                // username already taken
                return (false, "registration was unsuccessful")
            }
        }
        
        // username not taken - add to userList and try to log in
        let user = User(username: username, password: password)
        self.userList.append(user)
        return self.loginUser(withUsername: user.username, andPassword: user.password)
    }
}