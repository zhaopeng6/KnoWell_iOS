//
//  LoginViewControlller.swift
//  KnoWell
//
//  Created by Banerji Udayan-UBANERJI on 3/1/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//
//
//  LoginViewController.swift
//  ParseDemo
//
//  Created by Rumiya Murtazina on 7/28/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit

import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    func goToMainView() {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("StartingPoint")
        self.presentViewController(viewController, animated: true, completion: nil)
    }

    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }

    func showAlert(title: String, message: String, alertTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: alertTitle, style: .Default, handler: nil)
        alertController.addAction(defaultAction)

        presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func loginAction(sender: AnyObject) {
        let username = self.usernameField.text
        let password = self.passwordField.text

        // Validate the text fields
        if username?.characters.count < 5 {

        } else if password?.characters.count < 6 {
            showAlert("Invalid", message: "Password must be greater than 5 characters", alertTitle: "OK")
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()

            // Send a request to login
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in

                // Stop the spinner
                spinner.stopAnimating()

                if ((user) != nil) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.goToMainView()
                    })
                } else {
                    self.showAlert("Error", message: "\(error)", alertTitle: "OK")
                }
            })
        }
    }

    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() != nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.goToMainView();
            })
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

