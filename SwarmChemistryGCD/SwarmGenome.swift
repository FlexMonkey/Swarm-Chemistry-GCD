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
    public var c1_cohesion : Double;
    public var c2_alignment : Double;
    public var c3_seperation : Double;
    public var c4_steering : Double;
    public var c5_paceKeeping : Double;
    
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
}