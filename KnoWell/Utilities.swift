//
//  Utilities.swift
//  KnoWell
//
//  Created by Banerji Udayan-UBANERJI on 3/3/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import Foundation

class Utilities {
    
    // Generate a CIImage QR Code for the given String
    static func generateQRCode(inputString: String) -> CIImage? {
        let data = inputString.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("Q", forKey: "inputCorrectionLevel")
            return filter.outputImage
        }
        return nil
    }
    
    // Set the image view to the QR code generated for the given String
    static func setImageViewToQRCode(uiImageView: UIImageView, qrString: String) {
        if let qrcodeImage = generateQRCode(qrString) {
            
            let scaleX = uiImageView.frame.size.width / qrcodeImage.extent.size.width
            let scaleY = uiImageView.frame.size.height / qrcodeImage.extent.size.height
            
            let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
            
            uiImageView.image = UIImage(CIImage: transformedImage)
        } else {
            NSLog("SilentError: Cannot generate a QR code for the given string")
        }
    }
}