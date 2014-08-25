//
//  SwarmGenome.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 21/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation
import UIKit;

public class SwarmGenome
{
    public var color : UIColor;
    
    public var normalSpeed : Double = 1;
    public var maximumSpeed : Double = 2;
    public var radius : Double;
    public var c1_cohesion : Double; // 1: 0 -> 5
    public var c2_alignment : Double; // 2: 0 -> 1
    public var c3_seperation : Double; // 3: 0 -> 100
    public var c4_steering : Double; // 4: 0 -> 1
    public var c5_paceKeeping : Double; // 5: 0 -> 1
    
    init(color : UIColor, radius : Double, c1_cohesion : Double, c2_alignment : Double, c3_seperation : Double, c4_steering : Double, c5_paceKeeping : Double)
    {
        self.color = color;
        self.radius = radius;
        self.c1_cohesion = c1_cohesion;
        self.c2_alignment = c2_alignment;
        self.c3_seperation = c3_seperation;
        self.c4_steering = c4_steering;
        self.c5_paceKeeping = c5_paceKeeping;
    }
    
    func setPropertyValueByIndex(newValue : Float, propertyIndex : Int)
    {
        switch(propertyIndex)
        {
            case 0:
                radius = Double(newValue);
            case 1:
                c1_cohesion = Double(newValue);
            case 2:
                c2_alignment = Double(newValue);
            case 3:
                c3_seperation = Double(newValue);
            case 4:
                c4_steering = Double(newValue);
            case 5:
                c5_paceKeeping = Double(newValue);
            default:
                break;
        }
    }
    
    func getPropertyValueByIndex(propertyIndex : Int) -> Float
    {
        var returnObject : Float?;
        
        switch(propertyIndex)
        {
            case 0:
                returnObject = Float(radius);
            case 1:
                returnObject = Float(c1_cohesion);
            case 2:
                returnObject = Float(c2_alignment);
            case 3:
                returnObject = Float(c3_seperation);
            case 4:
                returnObject = Float(c4_steering);
            case 5:
                returnObject = Float(c5_paceKeeping);
            default:
                returnObject = 0;
        }

        return returnObject!;
    }
    
    class func getMinMaxForProperty(propertyIndex : Int) -> (min: Float, max: Float)
    {
        var returnObject : (min: Float, max: Float)?;
        
        switch(propertyIndex)
        {
            case 0:
                returnObject = (0, 100);
            case 1:
                returnObject = (0, 5);
            case 2:
                returnObject = (0, 1);
            case 3:
                returnObject = (0, 100);
            case 4:
                returnObject = (0, 1);
            case 5:
                returnObject = (0, 1);
            default:
                returnObject = (0, 0);
        }
        
        return returnObject!;
    }
}