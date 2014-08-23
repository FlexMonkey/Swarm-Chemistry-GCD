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
    return UIImage(CGImage: cgim)
}

func renderSwarmChemistry (swarmMembers : [SwarmMember]) -> UIImage
{
    var pixelArray = [PixelData](count: Constants.IMAGE_LENGTH, repeatedValue: PixelData(a: 255, r:0, g: 0, b: 0));
    
    for swarmMember in swarmMembers
    {
        let index : Int = Int(swarmMember.y * Constants.WIDTH + swarmMember.x);
        
        println("length \(Constants.IMAGE_LENGTH)  index \(index)")
        
        if index < Constants.IMAGE_LENGTH
        {
            let colorRef = CGColorGetComponents(swarmMember.genome.color.CGColor);
            
            pixelArray[index].r = UInt8(255 * colorRef[0]);
            pixelArray[index].g = UInt8(255 * colorRef[1]);
            pixelArray[index].b = UInt8(255 * colorRef[2]);
        }
    }
    
    let outputImage = imageFromARGB32Bitmap(pixelArray, UInt(Constants.WIDTH), UInt(Constants.HEIGHT))
    
    return outputImage;
}
