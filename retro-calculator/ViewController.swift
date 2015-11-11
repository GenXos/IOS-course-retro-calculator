//
//  ViewController.swift
//  retro-calculator
//
//  Created by Todd Fields on 2015-11-11.
//  Copyright © 2015 Todd Fields. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  @IBOutlet weak var outputLbl: UILabel!
  
  var btnSound: AVAudioPlayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
    
    let soundURL = NSURL(fileURLWithPath: path!)
    
    do {
      try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
      btnSound.prepareToPlay()
    } catch let err as NSError {
      print(err.debugDescription)
    }
    
  }

  @IBAction func numberPressed(btn: UIButton!) {
    
    btnSound.play()
  }


}

