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
    
    var selectedGenomeIndex : Int = 0;
    
    let genomes : Array<SwarmGenome> = [Constants.genomeOne, Constants.genomeTwo, Constants.genomeThree, Constants.genomeFour];

    var image : UIImage?;

    var swarmMembers = NSMutableArray(capacity: Constants.COUNT)
    
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet var propertyButtonBar: UISegmentedControl!
    @IBOutlet var propertyValueSlider: UISlider!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for var i = 0; i < Constants.COUNT; i++
        {
            let genome : SwarmGenome = genomes[i % 4];
            var swarmMember : SwarmMember = SwarmMember(genome: genome);
            
            swarmMember.x = Double(Int(rand()) % Int(Constants.WIDTH));
            swarmMember.y = Double(Int(rand()) % Int(Constants.HEIGHT));
            
            swarmMembers.addObject(swarmMember);
        }
        
        setPropertSliderMinMax();
        setPropertySliderValue();
        
        dispatchSolve();
    }
    
    func dispatchSolve()
    {
        Async.background
        {
            solveSwarmChemistry(self.swarmMembers);
        }
        .main
        {
            self.dispatchRender();
            self.dispatchSolve();
        }
    }
    
    func dispatchRender()
    {
        Async.background
        {
            self.image = renderSwarmChemistry(self.swarmMembers);
        }
        .main
        {
            self.uiImageView.image = self.image;
        }
    }
    
    func setGenomeValue()
    {
        genomes[selectedGenomeIndex].setPropertyValueByIndex(propertyValueSlider.value, propertyIndex: propertyButtonBar.selectedSegmentIndex);
    }
    
    func setPropertySliderValue()
    {
        propertyValueSlider.value = genomes[selectedGenomeIndex].getPropertyValueByIndex(propertyButtonBar.selectedSegmentIndex);
    }
    
    func setPropertSliderMinMax()
    {
        propertyValueSlider.minimumValue = SwarmGenome.getMinMaxForProperty(propertyButtonBar.selectedSegmentIndex).min;
        
        propertyValueSlider.maximumValue = SwarmGenome.getMinMaxForProperty(propertyButtonBar.selectedSegmentIndex).max;
    }
    
    // event handlers
    
    @IBAction func propertyButtonBarChangeHandler(sender: AnyObject)
    {
        setPropertSliderMinMax();
        setPropertySliderValue();
    }
    
    @IBAction func propertySliderChangeHandler(sender: AnyObject)
    {
        setGenomeValue();
    }
}

