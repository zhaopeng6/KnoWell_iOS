//
//  ViewController.swift
//  KnoWell
//
//  Created by zhaopeng on 1/31/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit

class SelfinfoController: UIViewController, UITextFieldDelegate{
    
    //MARK:Properties
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var companyTextField: UILabel!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var contactTextField: UILabel!
    @IBOutlet weak var portraitImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show the current visitor's username
        if let currentCard = Card.getCurrentUserCard() {
            self.nameTextField.text = currentCard.firstName
            self.companyTextField.text = currentCard.company
            Utilities.setImageViewToQRCode(portraitImageView, qrString: currentCard.getQRCodeString())
        } else {
            logOutAction(self)
        }
    }
    
    @IBAction func logOutAction(sender: AnyObject){
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelToSelfInfoViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveCardDetail(segue:UIStoryboardSegue){
        
    }
    
    
}

