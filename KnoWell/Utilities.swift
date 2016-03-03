//
//  Utilities.swift
//  KnoWell
//
//  Created by Banerji Udayan-UBANERJI on 3/3/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import Foundation

class Utilities {
    static func generateQRCode(inputString: String) -> UIImage {
        let data = inputString.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        return UIImage(CIImage: filter!.outputImage!)
    }
}