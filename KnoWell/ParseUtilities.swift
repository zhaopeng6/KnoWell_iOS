//
//  ParseUtilities.swift
//  KnoWell
//
//  Created by Banerji Udayan-UBANERJI on 4/6/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import Foundation

class ParseUtilities {
    static var synced:Bool = false

    static func getECardInfoFromUserId(objId: String?, local:Bool = false) -> PFObject? {
        if (objId == nil) {
            print("SilentError: Cannot get ECardInfo since objId is nill")
            return nil
        }

        let query = PFQuery(className:"ECardInfo")
        if local {
            query.fromLocalDatastore()
        }

        query.whereKey("userId", equalTo: objId!)

        var toReturn:PFObject?
        do {
            toReturn = try query.getFirstObject()
        } catch {
            print("SilentWarning: Error while fetching " + objId!)
        }

        if (toReturn == nil) {
            print("SilentWarning: returning nil for " + objId!)
        } else {
            toReturn?.pinInBackground()
        }
        return toReturn
    }

    static func getECardInfoFromObjectId(objId: String?, local:Bool = false) -> PFObject? {
        if (objId == nil) {
            print("SilentError: Cannot get ECardInfo since objId is nill")
            return nil
        }

        let query = PFQuery(className:"ECardInfo")
        if local {
            query.fromLocalDatastore()
        }

        var toReturn: PFObject?
        do {
            try toReturn = query.getObjectWithId(objId!)
        } catch {}
        return toReturn
    }

    static func getAllContactsLocal(forObject: PFObject?, syncOnly: Bool = false) -> [PFObject]? {
        if forObject == nil {
            return nil
        }

        var contacts:[PFObject]?
        if !syncOnly {
            contacts = [PFObject]()
        }

        let query = PFQuery(className:"ECardNote")

        query.whereKey("userId", equalTo: forObject!["userId"] as! String)

        if synced {
            query.fromLocalDatastore()
        }

        do {
            let objects = try query.findObjects()

            for object in objects {
                object.pinInBackground()
                if let result = getECardInfoFromObjectId(object["ecardId"] as? String) {
                    result.pinInBackground()
                    if !syncOnly {
                        contacts!.append(result)
                    }
                }
            }
        } catch {}


        /* query.findObjectsInBackgroundWithBlock {
         (objects: [PFObject]?, error: NSError?) -> Void in

         if error == nil {
         // The find succeeded.
         print("Successfully retrieved \(objects!.count) scores.")
         // Do something with the found objects
         if let objects = objects {
         for object in objects {
         object.pinInBackground()
         if let result = getECardInfoFromObjectId(object["ecardId"] as? String) {
         result.pinInBackground()
         if !syncOnly {
         contacts!.append(result)
         }
         }
         }
         }
         } else {
         // Log details of the failure
         print("Error: \(error!) \(error!.userInfo)")
         }
         } */
        
        synced = true;
        
        return contacts
    }
}