//
//  ViewController.swift
//  SwarmChemistryGCD
//
//  Created by Simon Gladman on 21/08/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    let genomes : Array<SwarmGenome> = [Constants.genomeOne, Constants.genomeTwo, Constants.genomeThree, Constants.genomeFour];

    var image : UIImage?;

    var swarmMembers = [SwarmMember]();
    
    @IBOutlet weak var uiImageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for var i = 0; i < Constants.COUNT; i++
        {
            let genome : SwarmGenome = genomes[i % 4];
            var swarmMember : SwarmMember = SwarmMember(genome: genome);
            
            swarmMember.x = Double(Int(rand()) % Int(Constants.WIDTH));
            swarmMember.y = Double(Int(rand()) % Int(Constants.HEIGHT));
            
            swarmMembers.append(swarmMember);
        }
        
        dispatchSolve();
    }
    
    // rendering code....
    
    func dispatchSolve()
    {
        Async.background
        {
            self.swarmMembers = solveSwarmChemistry(self.swarmMembers);
        }
        .main
        {
            self.uiImageView.image = renderSwarmChemistry(self.swarmMembers);
            self.dispatchSolve();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

