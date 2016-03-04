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
    var name:String
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
    
    func getCardFromPFUser(pfUser: PFUser) -> Card? {
        return nil
    }
    
}
