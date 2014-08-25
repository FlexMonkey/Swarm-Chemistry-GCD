//
//  SwarmChemistryRenderer.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 23/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//
// Based on Joseph Lord's work at http://blog.human-friendly.com/drawing-images-from-pixel-data-in-swift


import Foundation
import UIKit

struct PixelData
{
    var a:UInt8 = 255
    var r:UInt8
    var g:UInt8
    var b:UInt8
}

private let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
private let bitmapInfo:CGBitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedFirst.toRaw())

private func imageFromARGB32Bitmap(pixels:[PixelData], width:UInt, height:UInt)->UIImage
{
    let bitsPerComponent:UInt = 8
    let bitsPerPixel:UInt = 32
    
    var data = pixels // Copy to mutable []
    let providerRef = CGDataProviderCreateWithCFData(NSData(bytes: &data, length: data.count * sizeof(PixelData)))
    
    let cgim = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, width * UInt(sizeof(PixelData)), rgbColorSpace,	bitmapInfo, providerRef, nil, true, kCGRenderingIntentDefault)
    
    return UIImage(CGImage: cgim);
}

var previousImage : CIImage?;

func renderSwarmChemistry (swarmMembers : [SwarmMember]) -> UIImage
{
    var pixelArray = [PixelData](count: Constants.IMAGE_LENGTH, repeatedValue: PixelData(a: 255, r:0, g: 0, b: 0));
    
    for swarmMember in swarmMembers
    {
        let pixelIndex : Int = Int(ceil(swarmMember.y) * Constants.WIDTH + ceil(swarmMember.x));
        
        if pixelIndex < Constants.IMAGE_LENGTH
        {
            let colorRef = CGColorGetComponents(swarmMember.genome.color.CGColor);
            
            pixelArray[pixelIndex].r = UInt8(255 * colorRef[0]);
            pixelArray[pixelIndex].g = UInt8(255 * colorRef[1]);
            pixelArray[pixelIndex].b = UInt8(255 * colorRef[2]);
        }
    }
    
    let outputImage = imageFromARGB32Bitmap(pixelArray, UInt(Constants.WIDTH), UInt(Constants.HEIGHT))
    
    return outputImage;
    
    /*
    
    // WIP - tinkering with blur filters and trails, too slow on A6 ipad
    
    let ciContext = CIContext(options: nil);
    let coreImage = CIImage(image: outputImage);

    if let tmp : CIImage = previousImage
    {
        let filter = CIFilter(name: "CIGaussianBlur");
        filter.setValue(tmp, forKey: kCIInputImageKey);
        filter.setValue(0.15, forKey: "inputRadius");
        
        let filteredImageData = filter.valueForKey(kCIOutputImageKey) as CIImage;
        
        let lightenFilter = CIFilter(name: "CIMaximumCompositing");
        
        lightenFilter.setValue(coreImage, forKey: "inputBackgroundImage");
        lightenFilter.setValue(filteredImageData, forKey: kCIInputImageKey);
        
        let filteredImageData_2 = lightenFilter.valueForKey(kCIOutputImageKey) as CIImage;
        let filteredImageRef_2 = ciContext.createCGImage(filteredImageData_2, fromRect: filteredImageData_2.extent());

        previousImage = CIImage(CGImage: filteredImageRef_2);

        return UIImage(CGImage: filteredImageRef_2);
    }
    else
    {
        let filter = CIFilter(name: "CIGaussianBlur");
        filter.setValue(coreImage, forKey: kCIInputImageKey);
        filter.setValue(0.5, forKey: "inputRadius");
        
        let filteredImageData = filter.valueForKey(kCIOutputImageKey) as CIImage;
        
        let filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent());
        
        previousImage = CIImage(CGImage: filteredImageRef);
        
        return UIImage(CGImage: filteredImageRef);
    }
*/
}
