//
//  ParseUtilities.swift
//  KnoWell
//
//  Created by Banerji Udayan-UBANERJI on 4/6/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import Foundation

class ParseUtilities {
    
    static func getParseObjectFromObjectID(objId: String, local:Bool = false) -> PFObject? {
        let query = PFQuery(className:"ECardInfo")
        if local {
            query.fromLocalDatastore()
        }
        query.getObjectInBackgroundWithId(objId).continueWithBlock({
            (task: BFTask!) -> AnyObject! in
            if task.error != nil {
                // There was an error.
                return task
            }
            
            // task.result will be your game score
            return task.result
        })
        
        return nil
    }
    
    
}