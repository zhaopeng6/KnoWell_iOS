//
//  ViewController.swift
//  KnoWell
//
//  Created by zhaopeng on 1/31/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController, UITextFieldDelegate{
    
    //MARK:Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var maincardView: UIView!
    
    @IBOutlet weak var lastModifiedTextField: UITextField!
    @IBOutlet weak var dateOfMetTextField: UITextField!
    @IBOutlet weak var placeOfMetTextField: UITextField!
    @IBOutlet weak var eventOfMetTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show the current visitor's username
        if let currentCard = Card.getCurrentUserCard() {
            self.nameTextField.text = currentCard.firstName + " " + currentCard.lastName
            self.companyTextField.text = currentCard.company
            self.titleTextField.text = currentCard.title
            self.contactTextField.text = currentCard.email
            self.portraitImageView.image = currentCard.portrait
            
          //  self.lastModifiedTextField.text = currentCard.emall
            view.addSubview(maincardView)
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

