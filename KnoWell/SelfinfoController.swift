//
//  ViewController.swift
//  KnoWell
//
//  Created by zhaopeng on 1/31/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit
import MessageUI

class SelfinfoController: UIViewController, UITextFieldDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {

    //MARK:Properties
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var companyTextField: UILabel!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var contactTextField: UILabel!
    @IBOutlet weak var portraitImageView: UIImageView!

    @IBOutlet weak var maincardView: UIView!
    @IBOutlet weak var cardbackView: UIView!

    @IBOutlet weak var qrCodeView: UIImageView!

    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var docBtn: UIButton!

    var textToShare = ""
    var progressViewController:ProgressViewController = ProgressViewController(message: "Loading Profile...")

    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }

    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(msg:String) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = [""]
        messageComposeVC.body = msg
        return messageComposeVC
    }

    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func docBtnClicked(sender: UIButton) {

        var receiverTextField : UITextField?;
        let docName = "Resume";

        var alert=UIAlertController(title: "Share " + docName + " To ...", message: nil, preferredStyle: UIAlertControllerStyle.Alert);
        //default input textField (no configuration...)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            // Enter the textfiled customization code here.
            receiverTextField = textField
            receiverTextField?.placeholder = "Who is this for?"
        }

        func handlerLink(act:UIAlertAction) {
            // it's a closure so we have a reference to the alert
            let tf = alert.textFields![0];

            textToShare = "Hi " + tf.text! + ", please accept my card";

            let objectsToShare = [textToShare]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            activityVC.popoverPresentationController?.sourceView = sender
            self.presentViewController(activityVC, animated: true, completion: nil)

            // print("User entered \(tf.text), tapped \(act.title)")
        }
        func handlerSMS(act:UIAlertAction){
            // Make sure the device can send text messages
            if (canSendText()) {
                // Obtain a configured MFMessageComposeViewController
                let tf = alert.textFields![0];

                textToShare = "Hi " + tf.text! + ", please accept my card";
                let messageComposeVC = configuredMessageComposeViewController(textToShare)

                // Present the configured MFMessageComposeViewController instance
                // Note that the dismissal of the VC will be handled by the messageComposer instance,
                // since it implements the appropriate delegate call-back
                presentViewController(messageComposeVC, animated: true, completion: nil)
            } else {
                // Let the user know if his/her device isn't able to send text messages
                let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
                errorAlert.show()
            }
        }
        func handleEmail(act:UIAlertAction){
            // this cannot be tested inside of browser, need real iphone
            //http://stackoverflow.com/questions/25604552/i-have-real-misunderstanding-with-mfmailcomposeviewcontroller-in-swift-ios8-in
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["paul@hackingwithswift.com"])
                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

                presentViewController(mail, animated: true, completion: nil)
            } else {
                // show failure alert
            }
        }

        let buttonLink = UIAlertAction(title: "Via Link", style: .Default, handler: handlerLink)
        let buttonPhone = UIAlertAction(title: "Via Text Msg", style: .Default, handler: handlerSMS)
        let buttonEmail = UIAlertAction(title: "Via Email", style: .Default, handler: handleEmail)
        let buttonCancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            print("Cancel Button Pressed")
        }
        alert.addAction(buttonLink);
        alert.addAction(buttonPhone);
        alert.addAction(buttonEmail);
        alert.addAction(buttonCancel);

        presentViewController(alert, animated: true, completion: nil);
    }

    @IBAction func shareBtnClicked(sender: UIButton) {

        var receiverTextField : UITextField?;
        //
        var alert=UIAlertController(title: "Share My Card To ... ", message: nil,preferredStyle: UIAlertControllerStyle.Alert);
        //default input textField (no configuration...)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            // Enter the textfiled customization code here.
            receiverTextField = textField
            receiverTextField?.placeholder = "Who is this for?"
        }
        func handlerLink(act:UIAlertAction) {
            // it's a closure so we have a reference to the alert
            let tf = alert.textFields![0];

            textToShare = "Hi " + tf.text! + ", please accept my card";

            let objectsToShare = [textToShare]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            activityVC.popoverPresentationController?.sourceView = sender
            self.presentViewController(activityVC, animated: true, completion: nil)

            // print("User entered \(tf.text), tapped \(act.title)")
        }
        func handlerSMS(act:UIAlertAction){
            // Make sure the device can send text messages
            if (canSendText()) {
                // Obtain a configured MFMessageComposeViewController
                let tf = alert.textFields![0];

                textToShare = "Hi " + tf.text! + ", please accept my card";
                let messageComposeVC = configuredMessageComposeViewController(textToShare)

                // Present the configured MFMessageComposeViewController instance
                // Note that the dismissal of the VC will be handled by the messageComposer instance,
                // since it implements the appropriate delegate call-back
                presentViewController(messageComposeVC, animated: true, completion: nil)
            } else {
                // Let the user know if his/her device isn't able to send text messages
                let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
                errorAlert.show()
            }
        }
        func handleEmail(act:UIAlertAction){
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["paul@hackingwithswift.com"])
                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

                presentViewController(mail, animated: true, completion: nil)
            } else {
                // show failure alert
            }
        }


        let buttonLink = UIAlertAction(title: "Via Link", style: .Default, handler: handlerLink)
        let buttonPhone = UIAlertAction(title: "Via Text Msg", style: .Default, handler: handlerSMS)
        let buttonEmail = UIAlertAction(title: "Via Email", style: .Default, handler: handleEmail)
        let buttonCancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            print("Cancel Button Pressed")
        }
        alert.addAction(buttonLink);
        alert.addAction(buttonPhone);
        alert.addAction(buttonEmail);
        alert.addAction(buttonCancel);

        presentViewController(alert, animated: true, completion: nil);
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
        presentViewController(progressViewController, animated: true, completion: nil)

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

    func someAction(sender:UITapGestureRecognizer){
        performSelector(#selector(SelfinfoController.flip), withObject: nil)
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

