//
//  ViewController.swift
//  InkKit
//
//  Created by Shaps on 04/06/2016.
//  Copyright (c) 2016 Shaps. All rights reserved.
//

import UIKit
import InkKit

class ViewController: UIViewController {
  
  @IBOutlet var containerView: UIView!
  @IBOutlet var alignmentView: DrawView!
  
  @IBOutlet var scalingControl: UISegmentedControl!
  @IBOutlet var horizontalControl: UISegmentedControl!
  @IBOutlet var verticalControl: UISegmentedControl!
  
  @IBOutlet var textHAlignmentControl: UISegmentedControl!
  @IBOutlet var textVAlignmentControl: UISegmentedControl!
  
  @IBOutlet var rotationControl: UISlider!
  
  var originalFrame: CGRect!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    view.backgroundColor = UIColor.darkGrayColor()
    originalFrame = alignmentView.frame
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    update(scalingControl)
    update(horizontalControl)
    update(textHAlignmentControl)
  }
  
  @IBAction func rotationChanged(sender: UISlider) {
    update(sender)
  }
  
  @IBAction func scalingChanged(sender: UISegmentedControl) {
    update(sender)
  }
  
  @IBAction func alignmentChanged(sender: UISegmentedControl) {
    update(sender)
  }
  
  @IBAction func textAlignmentChanged(sender: UISegmentedControl) {
    update(sender)
  }
  
  private func updateAlignmentView(sender: UIControl) {
    switch sender {
    case scalingControl:
      let mode = ScaleMode(rawValue: scalingControl.selectedSegmentIndex)!
      alignmentView.frame = originalFrame.scaledTo(containerView.frame, scaleMode: mode)
    case textHAlignmentControl, textVAlignmentControl:
      alignmentView.horizontalAlignment = HorizontalAlignment(rawValue: textHAlignmentControl.selectedSegmentIndex)!
      alignmentView.verticalAlignment = VerticalAlignment(rawValue: textVAlignmentControl.selectedSegmentIndex)!
    case horizontalControl, verticalControl:
      let horizontal = HorizontalAlignment(rawValue: horizontalControl.selectedSegmentIndex)!
      let vertical = VerticalAlignment(rawValue: verticalControl.selectedSegmentIndex)!
      alignmentView.frame = alignmentView.frame.alignedTo(containerView.frame, horizontal: horizontal, vertical: vertical)
    case rotationControl:
      alignmentView.rotation = CGFloat(rotationControl.value)
    default: break
    }
  }
  
  private func update(control: UIControl) {
    UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.1, options: .BeginFromCurrentState, animations: {
      self.updateAlignmentView(control)
    }, completion: nil)
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
     return .LightContent
  }
  
}

