//
//  MArtifactView
//  Moosnick Museum
//
//  Created by Robert England on 3/11/18 for ViewMasterSwift
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//  Abstract: Displays the packet information in a large format tile.
//

import UIKit

@objc(MArtifactView)
class MArtifactView: UIImageView {
    
    weak var viewController: MArtifactViewController?
    
    // yes, this view can become first responder
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //// RE:: lifted verbatim from Swift translation of The Elements --- I don't understand any of it
    private func AEViewCreateGradientImage(_ pixelsWide: Int, _ pixelsHigh: Int) -> CGImage? {
        
        var theCGImage: CGImage? = nil
        
        // our gradient is always black-white and the mask must be in the gray colorspace
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        // create the bitmap context
        //// (wasn't bitsPerComponent 0 is example?!)
        if let gradientBitmapContext = CGContext(data: nil, width: pixelsWide, height: pixelsHigh,
                                                 bitsPerComponent: 8, bytesPerRow: 0,
                                                 space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) {
            
            // define the start and end grayscale values (with the alpha, even though our bitmap context
            //    doesn't support alpha, the gradient requires it)
            let colors: [CGFloat] = [0.0, 1.0, 1.0, 1.0]
            
            // create the CGGradient and then release the gray color space
            let grayScaleGradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: nil, count: 2)
            
            // create the start and end points for the gradient vector (straight down)
            let gradientStartPoint = CGPoint.zero
            let gradientEndPoint = CGPoint(x: 0, y: CGFloat(pixelsHigh))
            
            // draw the gradient into the gray bitmap context
            gradientBitmapContext.drawLinearGradient (grayScaleGradient!, start: gradientStartPoint, end: gradientEndPoint,
                                                      options: CGGradientDrawingOptions.drawsAfterEndLocation)
            
            // clean up the gradient   (RE:: ??)
            
            // convert the context into a CGImageRef and release the context
            theCGImage = gradientBitmapContext.makeImage()
            
        }
        else {
            print("CCC")
        }
        
        // clean up the colorspace   (RE:: ??)
        
        // return the imageRef containing the gradient
        return theCGImage
    }

    //// RE:: also lifted verbatim from Swift translation of The Elements --- I don't understand any of it
    func reflectedImageRepresentationWithHeight(_ height: Int) -> UIImage? {
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // create a bitmap graphics context the size of the image
        guard let mainViewContentContext = CGContext(data: nil, width: Int(self.bounds.size.width), height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            
            // free the rgb colorspace
            
            return nil
        }
        
        // offset the context. This is necessary because, by default, the layer created by a view for
        // caching its content is flipped. But when you actually access the layer content and have
        // it rendered it is inverted. Since we're only creating a context the size of our
        // reflection view (a fraction of the size of the main view) we have to translate the context the
        // delta in size, render it, and then translate back
        
        let translateVertical = self.bounds.size.height - CGFloat(height)
        mainViewContentContext.translateBy(x: 0, y: -translateVertical)
        
        // render the layer into the bitmap context
        self.layer.render(in: mainViewContentContext)
        
        // translate the context back
        mainViewContentContext.translateBy(x: 0, y: translateVertical)
        
        // Create CGImageRef of the main view bitmap content, and then release that bitmap context
        let mainViewContentBitmapContext = mainViewContentContext.makeImage()
        if mainViewContentBitmapContext != nil {
            // print("it ain't mainViewContentBitmapContext")
        }
        
        // create a 2 bit CGImage containing a gradient that will be used for masking the
        // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
        // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
        let gradientMaskImage = AEViewCreateGradientImage(1, height)
        if gradientMaskImage != nil {
            // print("it ain't gradientMaskImage")
        }
        else {
            // print("yikes gradientmaskiMAGE")
            return nil
        }
        
        // Create an image by masking the bitmap of the mainView content with the gradient view
        // then release the pre-masked content bitmap and the gradient bitmap
//        let reflectionImage = mainViewContentBitmapContext?.masking(gradientMaskImage!)!
        let reflectionImage = mainViewContentBitmapContext?.masking((gradientMaskImage)!)
        
        // convert the finished reflection image to a UIImage
        let theImage = UIImage(cgImage: reflectionImage!)
        
        return theImage
    }
    
    
}
