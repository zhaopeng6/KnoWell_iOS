//
//  ParseUtilities.swift
//  KnoWell
//
//  Created by Banerji Udayan-UBANERJI on 4/6/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import Foundation

class ParseUtilities {

    static func getParseObjectFromObjectID(objId: String?, local:Bool = false) -> PFObject? {
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
        }
        return toReturn
    }
}