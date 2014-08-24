//
//  SwarmChemistryMember.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 21/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation

@objc class SwarmMember
{
    var genome : SwarmGenome;
    
    var x : Double = 0.0;
    var y : Double = 0.0;
    
    var dx : Double = 0.0;
    var dy : Double = 0.0;
    
    var dx2 : Double = 0.0;
    var dy2 : Double = 0.0;
    
    var distance : Double = 0.0;
    
    init(genome : SwarmGenome)
    {
        self.genome = genome;
    }

     func move()
    {
        dx = dx2;
        dy = dy2;
        
        x = x + dx;
        y = y + dy;
        
        if y < 0
        {
            y = 0;
        }
        else if y > Constants.HEIGHT
        {
            y = Constants.HEIGHT;
        }
        
        if x < 0
        {
            x = 0
        }
        else if x > Constants.WIDTH
        {
            x =  Constants.WIDTH;
        }
    }
    
     func accelerate(#ax : Double, ay : Double, maxMove : Double)
    {
        dx2 += ax;
        dy2 += ay;
        
        var d : Double = dx2 * dx2 + dy2 * dy2;
        
        if d > maxMove * maxMove
        {
            var normalizationFactor : Double = maxMove / sqrt(d);
            dx2 *= normalizationFactor;
            dy2 *= normalizationFactor;
        }
    }

}
