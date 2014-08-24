//
//  SwarmChemistrySolver.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 21/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation

func solveSwarmChemistry(swarmMembers :  NSMutableArray)
{
    let startIndex = 0;
    let sampleSize = swarmMembers.count;
    let n = startIndex + sampleSize;
    
    for var i : Int = startIndex; i < n; i++
    {
        var swarmMember : SwarmMember = swarmMembers[i] as SwarmMember;
        
        var neighbours : NSMutableArray = NSMutableArray();
        var localCentreX : Double = 0;
        var localCentreY : Double = 0;
        var localDx : Double = 0;
        var localDy : Double = 0;
        
        var tempAx : Double = 0;
        var tempAy : Double = 0;
        
        for var j : Int = 0; j < n; j++
        {
            var candidateNeighbour = swarmMembers[j] as SwarmMember;
            
            let distance = hypot(swarmMember.x - candidateNeighbour.x, swarmMember.y - candidateNeighbour.y)
            
            if distance < swarmMember.genome.radius
            {
                candidateNeighbour.distance = distance;
                
                if candidateNeighbour.distance < 0.0001
                {
                    candidateNeighbour.distance = 0.0001
                }
                
                neighbours.addObject(candidateNeighbour);
                
                localCentreX = localCentreX + candidateNeighbour.x;
                localCentreY = localCentreY + candidateNeighbour.y;
                localDx = localDx + candidateNeighbour.dx;
                localDy = localDy + candidateNeighbour.dy;
            }
            
        }
        
        localCentreX = localCentreX / Double(neighbours.count);
        localCentreY = localCentreY / Double(neighbours.count);
        localDx = localDx / Double(neighbours.count);
        localDy = localDy / Double(neighbours.count);
        
        
        // do swarm chemisty....
        
        tempAx = tempAx + (localCentreX - Double(swarmMember.x)) * swarmMember.genome.c1_cohesion;
        tempAy = tempAy + (localCentreY - Double(swarmMember.y)) * swarmMember.genome.c1_cohesion;
        
        tempAx = tempAx + (localDx - swarmMember.dx) * swarmMember.genome.c2_alignment;
        tempAy = tempAy + (localDy - swarmMember.dy) * swarmMember.genome.c2_alignment;
        
        
        for var k = 0; k < neighbours.count; k++
        {
            var neighbour : SwarmMember = neighbours[k] as SwarmMember;
            var foo = neighbour.distance * swarmMember.genome.c3_seperation
            
            tempAx = tempAx + Double(swarmMember.x - neighbour.x) / foo;
            tempAy = tempAy + Double(swarmMember.y - neighbour.y) / foo;
        }
        
        
        if Double(rand() % 100) < (swarmMember.genome.c4_steering * 100.0)
        {
            tempAx = tempAx + Double(rand() % 4) - 1.5;
            tempAy = tempAy + Double(rand() % 4) - 1.5;
        }
        
        swarmMember.accelerate(ax: tempAx,
            ay: tempAy,
            maxMove: swarmMember.genome.maximumSpeed);
        
        let distance = max(sqrt(swarmMember.dx2 * swarmMember.dx2 +  swarmMember.dy2 *  swarmMember.dy2), 0.001);
        
        let accelerateMultiplier = (swarmMember.genome.normalSpeed - distance) / distance * swarmMember.genome.c5_paceKeeping;
        
        swarmMember.accelerate(
            ax: swarmMember.dx2 * accelerateMultiplier,
            ay: swarmMember.dy2 * accelerateMultiplier,
            maxMove: swarmMember.genome.maximumSpeed);
        
        
    }
    
    for var i : Int = startIndex; i < n; i++
    {
        var swarmMember : SwarmMember = swarmMembers[i] as SwarmMember;
        swarmMember.move();
    }
}