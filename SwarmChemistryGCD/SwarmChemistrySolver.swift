//
//  SwarmChemistrySolver.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 21/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//
//  Swarm Chemistry based on work by Hiroki Sayama
//  http://bingweb.binghamton.edu/~sayama/SwarmChemistry/
//

import Foundation

func solveSwarmChemistry(swarmMembers : [SwarmMember]) -> [SwarmMember]
{
    var returnArray = swarmMembers;
    
    for var i : Int = 0; i < Constants.COUNT; i++
    {
        var swarmMember : SwarmMember = swarmMembers[i];
        
        //distancesvar neighbourCount : Int = 0;
        //var neighbours = swarmMembers;
        var localCentreX : Double = 0;
        var localCentreY : Double = 0;
        var localDx : Double = 0;
        var localDy : Double = 0;
        
        var tempAx : Double = 0;
        var tempAy : Double = 0;
        
        var distances = [Distance]();
        
        for var j : Int = 0; j < Constants.COUNT; j++
        {
            let candidateNeighbour = swarmMembers[j];
            
            let distance = hypot(swarmMember.x - candidateNeighbour.x, swarmMember.y - candidateNeighbour.y)
            
            if distance < swarmMember.genome.radius
            {
                let candidateNeighbourDistance = max(distance, 0.0001);
            
                //neighbours[neighbourCount++] = candidateNeighbour;
                distances.append(Distance(distance: candidateNeighbourDistance, x: candidateNeighbour.x, y: candidateNeighbour.y));
                
                localCentreX = localCentreX + candidateNeighbour.x;
                localCentreY = localCentreY + candidateNeighbour.y;
                localDx = localDx + candidateNeighbour.dx;
                localDy = localDy + candidateNeighbour.dy;
            }
        }
        
        localCentreX = localCentreX / Double(distances.count);
        localCentreY = localCentreY / Double(distances.count);
        localDx = localDx / Double(distances.count);
        localDy = localDy / Double(distances.count);
        
        
        // do swarm chemisty....
        
        tempAx = tempAx + (localCentreX - Double(swarmMember.x)) * swarmMember.genome.c1_cohesion;
        tempAy = tempAy + (localCentreY - Double(swarmMember.y)) * swarmMember.genome.c1_cohesion;
        
        tempAx = tempAx + (localDx - swarmMember.dx) * swarmMember.genome.c2_alignment;
        tempAy = tempAy + (localDy - swarmMember.dy) * swarmMember.genome.c2_alignment;
        
        
        for var k = 0; k < distances.count; k++
        {
            var neighbour = distances[k];
            var foo = distances[k].distance * swarmMember.genome.c3_seperation
            
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
        
        let distance = max(hypot(swarmMember.dx2, swarmMember.dy2), 0.00001);
        
        let accelerateMultiplier = (swarmMember.genome.normalSpeed - distance) / distance * swarmMember.genome.c5_paceKeeping;
        
        swarmMember.accelerate(
            ax: swarmMember.dx2 * accelerateMultiplier,
            ay: swarmMember.dy2 * accelerateMultiplier,
            maxMove: swarmMember.genome.maximumSpeed);
        
        swarmMember.move();
        
        returnArray[i] = swarmMember
    }
    
    return returnArray; 
}