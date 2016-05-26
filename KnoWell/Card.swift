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
    var objID:String

    var userID:String

    var about:String
    var message:String
    var motto:String

    var city:String
    var company:String

    var email:String
    var facebook:String
    var gplus:String
    var linkedin:String
    var twitter:String
    var web:String


    var title:String
    var firstName:String
    var lastName:String
    var portrait:UIImage

    var phone:String

    static var currentUserCard:Card?

    //Mark: Initialization
    init?(objId: String, userId: String,
          about: String?, message: String?, motto: String?,
          city: String?, company: String?,
          email: String?, facebook: String?, gplus: String?,
          linkedin: String?, twitter: String?, web: String?,
          title: String?, firstName: String?, lastName: String?, portrait: UIImage?,
          phone: String?){

        self.objID = objId
        self.userID = userId

        self.about = about ?? ""
        self.message = message ?? ""
        self.motto = motto ?? ""

        self.city = city ?? ""
        self.company = company ?? ""

        self.email = email ?? ""
        self.facebook = facebook ?? ""
        self.gplus = gplus ?? ""
        self.linkedin = linkedin ?? ""
        self.twitter = twitter ?? ""
        self.web = web ?? ""

        self.title = title ?? ""
        self.firstName = firstName ?? ""
        self.lastName = lastName ?? ""

        self.phone = phone ?? ""

        self.portrait = portrait ?? UIImage(named: "Obama")!
    }

    func getQRCodeString() -> String {
        return "TODO"
    }

    static func getCardFromPFObject(pfObject: PFObject?) -> Card? {
        if pfObject == nil || pfObject!.objectId == nil || pfObject!["userId"] == nil {
            print("SilentError: Current Card is nill because pfObject is null")
            return nil
        }

        var portraitImage: UIImage?
        do {
            if let portrait = pfObject!["portrait"] {
                let portraitImageData:PFFile = portrait as! PFFile
                portraitImage = try UIImage(data:portraitImageData.getData())!

            }
        } catch {
            return nil
        }

        return Card(objId:pfObject!.objectId!,
                    userId:pfObject!["userId"] as! String,

                    about:pfObject!["about"] as? String,
                    message:pfObject!["message"] as? String,
                    motto:pfObject!["motto"] as? String,

                    city:pfObject!["city"] as? String,
                    company:pfObject!["company"] as? String,

                    email: pfObject!["email"] as? String,
                    facebook: pfObject!["facebook"] as? String,
                    gplus: pfObject!["googleplus"] as? String,
                    linkedin: pfObject!["linkedin"] as? String,
                    twitter: pfObject!["twitter"] as? String,
                    web: pfObject!["web"] as? String,

                    title: pfObject!["title"] as? String,
                    firstName: pfObject!["firstName"] as? String,
                    lastName: pfObject!["lastName"] as? String,
                    portrait:portraitImage,
                    phone: pfObject!["phone"] as? String)
    }

    static func getCurrentUserCard() -> Card? {
        if currentUserCard == nil {
            if PFUser.currentUser()?.objectId == nil {
                print("SilentError: Current User is nill because PFUser() objID is null")
                return nil
            }

            if let parseObj = ParseUtilities.getParseObjectFromObjectID((PFUser.currentUser()?.objectId)!) {
                print("SilentError: Got " + parseObj.objectId!)
                currentUserCard = getCardFromPFObject(parseObj)
            }
        }

        if currentUserCard == nil {
            print("SilentError: Current User is nill cannot get ECardInfo for the user")
        }
        return currentUserCard
    }

}
