//
//  Card.swift
//  KnoWell
//
//  Created by zhaopeng on 2/2/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit

class Card {
    //Mark: Properties
    var objID:String?
    var name:String?
    var portrait:UIImage?
    var title:String?
    var email:String?
    var phone:String?
    var location:String?
    var notes:String?
    var record:NSURL?
    
    //Mark: Initialization
    init?(name:String,portrait:UIImage?,title:String?,email:String?,phone:String?,location:String?,notes:String?,record:NSURL?){
        self.name = name
        self.portrait = portrait
        self.title = title
        self.email = email
        self.phone = phone
        self.location = location
        self.notes = notes
        self.record = record
        if name.isEmpty {
            return nil
        }
    }
    
    init() {
        self.name = "Default"
        self.portrait = UIImage(named: "Obama")
        self.title = "Default Title"
        self.email = "default@title.com"
        self.phone = "800-CAL-LIFE"
        self.location = "Default Location"
        self.notes = "No notes"
        self.record = NSURL(string: "www.micklestudios.com")
        
    }
    
    func getCardFromPFObject(pfObject: PFObject) -> Card? {
        let email = pfObject["email"] as! String
        let name = pfObject["firstName"] as! String
        var portraitImage: UIImage?
        do {
            if let portrait = pfObject["portrait"] {
                let portraitImageData:PFFile = portrait as! PFFile
                portraitImage = try UIImage(data:portraitImageData.getData())!
                
            }
        } catch {
            return nil
        }
        let title = pfObject["title"] as! String
        let phone = pfObject["phone"] as! String
        let location = pfObject["city"] as! String
        return Card(name: name, portrait: portraitImage, title: title, email: email, phone: phone, location: location, notes: notes, record: record)
    }
    
}
