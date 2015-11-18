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
  
  enum Operation: String {
    case Divide = "/"
    case Multiply = "*"
    case Subtract = "-"
    case Add = "+"
    case Clear = "Clear"
    case Empty = "Empty"
  }

  @IBOutlet weak var outputLbl: UILabel!
  
  var btnSound: AVAudioPlayer!
  var runningNumber = ""
  var leftValStr = ""
  var rightValStr = ""
  var result = ""
  var currentOperation: Operation = Operation.Empty
  
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
    playSound()
    
    runningNumber += "\(btn.tag)"
    outputLbl.text = runningNumber
  }

  @IBAction func onDividePressed(sender: AnyObject) {
    processOperation(Operation.Divide)
  }

  @IBAction func onMultiplyPressed(sender: AnyObject) {
    processOperation(Operation.Multiply)
  }
  
  @IBAction func onAddPressed(sender: AnyObject) {
    processOperation(Operation.Add)
  }
  
  @IBAction func onSubtractPressed(sender: AnyObject) {
    processOperation(Operation.Subtract)
  }
  
  @IBAction func onEqualPressed(sender: AnyObject) {
    processOperation(currentOperation)
  }
  
  @IBAction func onClearPressed(sender: AnyObject) {
    clear()
  }
  
  func processOperation(op: Operation!) {
    playSound()
    
    if currentOperation != Operation.Empty {
      
      // user selected an operator and then changed it to another operator
      // without entering a number
      if runningNumber != "" {
        rightValStr = runningNumber
        runningNumber = ""
        
        if currentOperation == Operation.Divide {
          result = "\(Double(leftValStr)! / Double(rightValStr)!)"
        } else if currentOperation == Operation.Multiply {
          result = "\(Double(leftValStr)! * Double(rightValStr)!)"
        } else if currentOperation == Operation.Add {
          result = "\(Double(leftValStr)! + Double(rightValStr)!)"
        } else if currentOperation == Operation.Subtract {
          result = "\(Double(leftValStr)! - Double(rightValStr)!)"
        }
        
        leftValStr = result
        outputLbl.text = result
        currentOperation = op
      }
      

      
    } else {
      leftValStr = runningNumber
      runningNumber = ""
      currentOperation = op
    }
  }
  
  func playSound() {
    if btnSound.playing {
      btnSound.stop()
    }
    
    btnSound.play()
  }
  
  func clear() {
    playSound()
    
    runningNumber = ""
    leftValStr = ""
    rightValStr = ""
    result = ""
    outputLbl.text = "0"
    currentOperation = Operation.Empty
  }
  
}

