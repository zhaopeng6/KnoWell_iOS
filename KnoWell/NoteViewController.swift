//
//  ViewController.swift
//  KnoWell
//
//  Created by zhaopeng on 1/31/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit
import MessageUI

class NoteViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var portraitImageView: UIImageView!
    
    @IBOutlet weak var maincardView: UIView!
    @IBOutlet weak var cardbackView: UIView!
    
    @IBOutlet weak var qrCodeView: UIImageView!
    
    
    var textToShare = ""
    var progressViewController:ProgressViewController = ProgressViewController(message: "Loading Profile...")
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }

    
    var flagFront = true
    
    
    func flip() {
        let transitionOptions: UIViewAnimationOptions = [.TransitionFlipFromRight, .ShowHideTransitionViews]
        
        if(flagFront){
            UIView.transitionWithView(maincardView, duration: 1.0, options: transitionOptions, animations: {
                self.maincardView.hidden = true
                }, completion: nil)
            
            UIView.transitionWithView(cardbackView, duration: 1.0, options: transitionOptions, animations: {
                self.cardbackView.hidden = false
                }, completion: nil)
            flagFront = false
        } else {
            UIView.transitionWithView(maincardView, duration: 1.0, options: transitionOptions, animations: {
                self.maincardView.hidden = false
                }, completion: nil)
            
            UIView.transitionWithView(cardbackView, duration: 1.0, options: transitionOptions, animations: {
                self.cardbackView.hidden = true
                }, completion: nil)
            flagFront = true
        }
    }
    
    func setUIToCard(currentCard:Card) {
        self.nameTextField.text = currentCard.firstName + " " + currentCard.lastName
        self.companyTextField.text = currentCard.company
        self.titleTextField.text = currentCard.title
        self.contactTextField.text = currentCard.email
        
        Utilities.setImageViewToQRCode(qrCodeView, qrString: currentCard.getQRCodeString())
        
        progressViewController.dismissViewControllerAnimated(true, completion: nil)
        flip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        presentViewController(progressViewController, animated: true, completion: nil)
        
        flagFront = false
        cardbackView.hidden = false
        
        view.addSubview(cardbackView)
        view.addSubview(maincardView)
        
        var currentCard:Card?
        // Show the current visitor's username
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self] in
            currentCard = Card.getCurrentUserCard()
            
            if (currentCard != nil) {
                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                    self.setUIToCard(currentCard!)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                    self.logOutAction(self)
                }
            }
        }
        
        // 3. add action to myView
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SelfinfoController.someAction(_:)))
        view.addGestureRecognizer(gesture)
        
        //        let scanBtnImg = UIImage(named: "scan_button")
        //        scanBtn.setImage(scanBtnImg, forState: UIControlState.Normal)
        //        scanBtn.imageEdgeInsets = UIEdgeInsets(top:40, left:0, bottom:0, right:120)
        //
        //        scanBtn.setTitle("Add Card\n(Scan QR)", forState: UIControlState.Normal)
        //        scanBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //        scanBtn.titleEdgeInsets = UIEdgeInsets(top:20, left:-0, bottom:10, right:10)
        //
        //        let searchBtnImg = UIImage(named: "search_button")
        //        searchBtn.setImage(searchBtnImg, forState: UIControlState.Normal)
        //        searchBtn.imageEdgeInsets = UIEdgeInsets(top:40, left:0, bottom:0, right:120)
        //
        //        searchBtn.setTitle("Search\nCards", forState: UIControlState.Normal)
        //        searchBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //        searchBtn.titleEdgeInsets = UIEdgeInsets(top:20, left:-0, bottom:10, right:10)
        //
        //        let shareBtnImg = UIImage(named: "share_button")
        //        shareBtn.setImage(shareBtnImg, forState: UIControlState.Normal)
        //        shareBtn.imageEdgeInsets = UIEdgeInsets(top:40, left:0, bottom:0, right:120)
        //
        //        shareBtn.setTitle("Share\nMy Card", forState: UIControlState.Normal)
        //        shareBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //        shareBtn.titleEdgeInsets = UIEdgeInsets(top:20, left:-0, bottom:10, right:10)
        //
        //        let docBtnImg = UIImage(named: "doc_button")
        //        docBtn.setImage(docBtnImg, forState: UIControlState.Normal)
        //        docBtn.imageEdgeInsets = UIEdgeInsets(top:40, left:0, bottom:0, right:120)
        //
        //        docBtn.setTitle("Share\nMy Doc", forState: UIControlState.Normal)
        //        docBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //        docBtn.titleEdgeInsets = UIEdgeInsets(top:20, left:-0, bottom:10, right:10)
        
    }
//
// //should add card flip function later
    
//    func someAction(sender:UITapGestureRecognizer){
//        performSelector(#selector(SelfinfoController.flip), withObject: nil)
//    }
    
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
    
    func updateCard(newCard:Card) {
        self.nameTextField.text = newCard.firstName + " " + newCard.lastName
        self.companyTextField.text = newCard.company
        self.titleTextField.text = newCard.title
        self.contactTextField.text = newCard.email
        Utilities.setImageViewToQRCode(portraitImageView, qrString: newCard.getQRCodeString())
        //self.portraitImageView.image = newCard.portrait
    }
    
    @IBAction func cancelToSelfInfoViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveCardDetail(segue:UIStoryboardSegue){
        let controller = segue.sourceViewController as! EditCardViewController
        
        // Pass the selected object to the new view controller.
        updateCard(controller.toEditCard!)
        
        //save to database later
    }
}

