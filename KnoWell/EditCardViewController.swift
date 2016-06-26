//
//  EditCardViewController.swift
//  KnoWell
//
//  Created by zhaopeng on 2/7/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit

class EditCardViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    // Mark: properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var portraitImageField: UIImageView!

    var toEditCard:Card?
    var buttonxcount=0
    var buttonycount=0
    var currentCard:Card!
    
    class IdentifiedButton: UIButton {
        var buttonIdentifier: String?
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            Card.currentUserCard = nil
            currentCard = Card.getCurrentUserCard()
            self.nameTextField.text = currentCard.firstName + " " + currentCard.lastName
            self.companyTextField.text = currentCard.company
            self.titleTextField.text = currentCard.title
            self.contactTextField.text = currentCard.email
            self.portraitImageField.image = currentCard.portrait
            
            //display other information
            if !currentCard.facebook.isEmpty {
                let buttonFB = IdentifiedButton(frame: CGRect(x:20+buttonxcount*70, y:320+buttonycount*70, width:50, height:50))
                buttonFB.setTitle("Facebook", forState: .Normal)
                buttonFB.tag = 1
                buttonFB.buttonIdentifier = currentCard.facebook
                buttonFB.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
                buttonFB.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
                buttonxcount += 1
                self.view.addSubview(buttonFB)
            }
            if !currentCard.twitter.isEmpty {
                let buttonTW = IdentifiedButton(frame: CGRect(x:20+buttonxcount*70, y:320+buttonycount*70, width:50, height:50))
                buttonTW.setTitle("Twitter", forState: .Normal)
                buttonTW.tag = 2
                buttonTW.buttonIdentifier = currentCard.twitter
                buttonTW.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
                buttonTW.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
                buttonxcount += 1
                self.view.addSubview(buttonTW)
            }
            if !currentCard.linkedin.isEmpty {
                let buttonLK = IdentifiedButton(frame: CGRect(x:20+buttonxcount*70, y:320+buttonycount*70, width:50, height:50))
                buttonLK.setTitle("LinkedIn", forState: .Normal)
                buttonLK.tag = 3
                buttonLK.buttonIdentifier = currentCard.linkedin
                buttonLK.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
                buttonLK.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
                buttonxcount += 1
                self.view.addSubview(buttonLK)
            }
            if !currentCard.gplus.isEmpty {
                let buttonGP = IdentifiedButton(frame: CGRect(x:20+buttonxcount*70, y:320+buttonycount*70, width:50, height:50))
                buttonGP.setTitle("GPlus", forState: .Normal)
                buttonGP.tag = 4
                buttonGP.buttonIdentifier = currentCard.gplus
                buttonGP.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
                buttonGP.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
                buttonxcount += 1
                self.view.addSubview(buttonGP)
            }
            if !currentCard.web.isEmpty {
                let buttonWB = IdentifiedButton(frame: CGRect(x:20+buttonxcount*70, y:320+buttonycount*70, width:50, height:50))
                buttonWB.setTitle("Web", forState: .Normal)
                if buttonxcount > 4 {
                    buttonxcount = 0;
                    buttonycount = 1;
                }
                buttonWB.tag = 5
                buttonWB.buttonIdentifier = currentCard.web
                buttonWB.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
                buttonWB.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
                buttonxcount += 1
                self.view.addSubview(buttonWB)
            }
            
            let buttonAdd = IdentifiedButton (frame: CGRect(x:20+buttonxcount*70, y:320+buttonycount*70, width:50, height:50))
            buttonAdd.setTitle("Add",forState: .Normal)
            buttonAdd.tag = 6
            buttonAdd.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
            buttonAdd.addTarget(self, action: #selector(buttonAction),forControlEvents: .TouchUpInside)
            self.view.addSubview(buttonAdd)
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField:UITextField)->Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        nameTextField.text = "obama"

    }

    //Mark: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder();
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated:true,completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage

        // Set photoImageView to display the selected image.
        portraitImageField.image = selectedImage

        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Mark:Actions
    func buttonAction(sender: IdentifiedButton!){
        switch sender.tag {
        case 1:
            let FBURL=NSURL(string:"fb://profile/PageId")!
            if UIApplication.sharedApplication().canOpenURL(FBURL) {
                UIApplication.sharedApplication().openURL(FBURL)
            } else{
                UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/"+sender.buttonIdentifier!)!)
            }
            break;
        case 2:
            let twitterURL = NSURL(string: "twitter:///user?screen_name=USERNAME")!
            if UIApplication.sharedApplication().canOpenURL(twitterURL) {
                UIApplication.sharedApplication().openURL(twitterURL)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/"+sender.buttonIdentifier!)!)
            }
            break;
        case 3:
            let linkedinURL = NSURL(string: "linkedin://company?id="+sender.buttonIdentifier!)!
            if UIApplication.sharedApplication().canOpenURL(linkedinURL) {
                UIApplication.sharedApplication().openURL(linkedinURL)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://linkedin.com/"+sender.buttonIdentifier!)!)
            }
            break;
        case 4:
            let googlePlusURL = NSURL(string: "gplus://plus.google.com/u/0/PageId")!
            if UIApplication.sharedApplication().canOpenURL(googlePlusURL) {
                UIApplication.sharedApplication().openURL(googlePlusURL)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://plus.google.com/"+sender.buttonIdentifier!)!)
            }
            break;
        case 5:
            UIApplication.sharedApplication().openURL(NSURL(string: "https://"+sender.buttonIdentifier!)!)
            break;
        case 6:
            return; //Add additional links, not sure how to do
        default:    return
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveCardSegue" {
            if let currentCard = Card.getCurrentUserCard() {
        
                let fullName:String = self.nameTextField.text!
                let fullNameArr = fullName.componentsSeparatedByString(" ")
                let firstName:String = fullNameArr[0]
                let lastName:String = fullNameArr[fullNameArr.endIndex-1]
                
                print(firstName)
                print(lastName)
                // Get the new view controller using segue.destinationViewController.
                toEditCard = Card(objId:currentCard.objID,userId:currentCard.userID,firstName: firstName, lastName: lastName, company:self.companyTextField.text, email:self.contactTextField.text, title:self.titleTextField.text, portrait:portraitImageField.image)
            }
            Card.saveCurrentUserCard(toEditCard!)
            
        }
    }
}
