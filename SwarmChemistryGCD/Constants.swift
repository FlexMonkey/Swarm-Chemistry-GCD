//
//  Constants.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 21/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//


import Foundation
import UIKit

struct Constants
{
    static let genomeOne = SwarmGenome(color: UIColor.redColor(), radius: 25, c1_cohesion: 1, c2_alignment: 0.25, c3_seperation: 45, c4_steering: 0.5, c5_paceKeeping: 1);
    static let genomeTwo = SwarmGenome(color: UIColor.blueColor(), radius: 50, c1_cohesion: 10, c2_alignment: 1, c3_seperation: 35, c4_steering: 0.25, c5_paceKeeping: 0.5);
    static let genomeThree = SwarmGenome(color: UIColor.greenColor(), radius: 100, c1_cohesion: 5, c2_alignment: 4, c3_seperation: 25, c4_steering: 1, c5_paceKeeping: 0.25);
    static let genomeFour = SwarmGenome(color: UIColor.whiteColor(), radius: 10, c1_cohesion: 17.5, c2_alignment: 1, c3_seperation: 50, c4_steering: 0.05, c5_paceKeeping: 1);
    
    
    static let WIDTH : Double = 480.0;
    static let HEIGHT : Double = 480.0;
    
    static let IMAGE_LENGTH = Int(WIDTH * HEIGHT);
    static let COUNT = 256;
}