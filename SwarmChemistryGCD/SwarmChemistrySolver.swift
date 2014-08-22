//
//  SwarmChemistrySolver.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 21/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import Foundation

func solveSwarmChemistry(swarmMembers : [SwarmMember]) -> [SwarmMember]
{
    var returnArray = swarmMembers;
    
    let startIndex = 0;
    let sampleSize = swarmMembers.count;
    let n = startIndex + sampleSize;
    
    for var i : Int = startIndex; i < n; i++
    {
        var swarmMember : SwarmMember = returnArray[i] as SwarmMember;
        
        // swarm chemistry...
        
        var neighbours : [SwarmMember] = [SwarmMember]();
        var localCentreX : Double = 0;
        var localCentreY : Double = 0;
        var localDx : Double = 0;
        var localDy : Double = 0;
        
        var tempAx : Double = 0;
        var tempAy : Double = 0;
        
        for tmp in swarmMembers
        {
            var candidateNeighbour = tmp as SwarmMember;
            
            let distance = sqrt((swarmMember.x - candidateNeighbour.x) * (swarmMember.x - candidateNeighbour.x)) + ((swarmMember.y - candidateNeighbour.y) * (swarmMember.y - candidateNeighbour.y));
            
            
            if distance < swarmMember.genome.radius
            {
                candidateNeighbour.distance = distance; //max,(distance, 0.001);
                
                if candidateNeighbour.distance < 0.0001
                {
                    candidateNeighbour.distance = 0.0001;
                }
                
                neighbours.append(candidateNeighbour);
                
                localCentreX += Double(candidateNeighbour.x);
                localCentreY += Double(candidateNeighbour.y);
                localDx += candidateNeighbour.dx;
                localDy += candidateNeighbour.dy;
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
        
        
        for tmp in neighbours
        {
            let neighbour = tmp as SwarmMember;
            
            tempAx = tempAx + Double(swarmMember.x - neighbour.x) / neighbour.distance * swarmMember.genome.c3_seperation;
            tempAy = tempAy + Double(swarmMember.y - neighbour.y) / neighbour.distance * swarmMember.genome.c3_seperation;
        }
        
        
        if Double(rand() % 100) < (swarmMember.genome.c4_steering * 100.0)
        {
            tempAx = tempAx + Double(rand() % 4) - 2.0;
            tempAy = tempAy + Double(rand() % 4) - 2.0;
        }
        
        
        
        swarmMember.accelerate(tempAx, ay: tempAy, maxMove: swarmMember.genome.maximumSpeed);
        
        var distance = sqrt(swarmMember.dx2 * swarmMember.dx2 +  swarmMember.dy2 *  swarmMember.dy2);
        
        if distance < 0.001
        {
            distance = 0.001;
        }
        
        
        swarmMember.accelerate(swarmMember.dx2 * (swarmMember.genome.normalSpeed - distance) / distance * swarmMember.genome.c5_paceKeeping,
            ay: swarmMember.dy2 * (swarmMember.genome.normalSpeed - distance) / distance * swarmMember.genome.c5_paceKeeping,
            maxMove: swarmMember.genome.maximumSpeed);
        
        swarmMember.move();
        
    }
    
    
    
    return returnArray;
}