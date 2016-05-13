//
//  CanvasViewController.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 11/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import InkKit

final class CanvasView: UIView {
  
  private var table: Grid!
  @IBOutlet var slider: UISlider!
  
  @IBAction func valueChanged(slider: UISlider) {
    setNeedsDisplay()
  }
  
  override func drawRect(bgFrame: CGRect) {
    super.drawRect(bgFrame)
    Draw.fillRect(bgFrame, color: UIColor(hex: "1c3d64"))
    
    
    drawAnimatedFrames(bgFrame)
    
    /*
     The commented code below, is ALL that is actually required to render to final UI.
     
     If you uncomment it to see the result, don't forget to comment the drawAnimatedFrames() call above this comment.
     */
    
    
//    let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
//    let navBarHeight: CGFloat = 44
//    
//    let margin: CGFloat = 0
//    let topGuide = statusBarHeight + navBarHeight
//    let barFrame = CGRect(x: 0, y: 0, width: bgFrame.width, height: topGuide)
//    let tableFrame = CGRect(x: 0, y: barFrame.maxY + margin, width: bgFrame.width, height: bgFrame.maxY - barFrame.height)
//    
//    
//    // Table
//    
//    let grid = Grid(colCount: 6, rowCount: 9, bounds: tableFrame)
//    let path = grid.path(includeComponents: [.Columns, .Rows])
//    
//    Draw.strokePath(path, startColor: UIColor(white: 1, alpha: 0.15), endColor: UIColor(white: 1, alpha: 0.05), angleInDegrees: 90)
//    
//    // Cell
//    
//    let rect = grid.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 4, destinationRow: 6)
//    drawCell(rect, title: "4x6", includeBorder: true, includeShadow: true)
//    
//    // Navigation Bar
//    
//    Draw.addShadow(.Outer, path: UIBezierPath(rect: barFrame), color: UIColor(white: 0, alpha: 0.4), radius: 5, offset: CGSize(width: 0, height: 1))
//    Draw.fillRect(barFrame, color: UIColor(hex: "ff0083"))
//    
//    let (_, navFrame) = barFrame.divide(20, fromEdge: .MinYEdge)
//    "InkKit".drawAlignedTo(navFrame, attributes: [
//      NSForegroundColorAttributeName: Color.whiteColor(),
//      NSFontAttributeName: UIFont(name: "Avenir-Book", size: 20)! ])
//    
//    backIndicatorImage().drawAtPoint(CGPoint(x: 22, y: 30))
  }
  
  func drawAnimatedFrames(bgFrame: CGRect) {
    let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
    let navBarHeight: CGFloat = 44
    
    let margin: CGFloat = 0
    let topGuide = statusBarHeight + navBarHeight
    let barFrame = CGRect(x: 0, y: 0, width: bgFrame.width, height: topGuide)
    let tableFrame = CGRect(x: 0, y: barFrame.maxY + margin, width: bgFrame.width, height: bgFrame.maxY - barFrame.height)
    
    if slider.value < 5 {
      drawPlaceholder(bgFrame)
    }
    
    if slider.value >= 11 {
      drawTable(tableFrame)
    }
    
    if slider.value >= 6 {
      drawNavigationBar(barFrame)
    }
    
    if slider.value > 27 {
      slider.hidden = false
    }
  }
  
  func drawPlaceholder(rect: CGRect) {
    "InkKit".drawAlignedTo(rect, attributes: [
      NSForegroundColorAttributeName: UIColor.whiteColor(),
      NSFontAttributeName: UIFont(name: "Avenir-Book", size: 60)!
    ])
  }
  
  func drawCell() {
    if slider.value > 20 && slider.value < 21 {
      let rect = table.boundsForCell	(col: 1, row: 1)
      drawCell(rect, title: "1x1")
    }
    
    if slider.value >= 21 && slider.value < 22 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 1)
      drawCell(rect, title: "2x1")
    } else
    
    if slider.value >= 22 && slider.value < 23 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 2)
      drawCell(rect, title: "2x2")
    }
    
    if slider.value >= 23 && slider.value < 24 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 2)
      drawCell(rect, title: "2x2", includeBorder: true, includeShadow: false)
    }
    
    if slider.value >= 24 && slider.value < 25 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 2)
      drawCell(rect, title: "2x2", includeBorder: true, includeShadow: true)
    }
    
    if slider.value >= 25 && slider.value < 26 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 4, destinationRow: 2)
      drawCell(rect, title: "4x2", includeBorder: true, includeShadow: true)
    }
    
    if slider.value >= 26 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 4, destinationRow: 6)
      drawCell(rect, title: "4x6", includeBorder: true, includeShadow: true)
    }
  }
  
  func drawCell(rect: CGRect, title: String, includeBorder: Bool = false, includeShadow: Bool = false) {
    let path = UIBezierPath(roundedRect: rect, cornerRadius: 4)
    
    Draw.fillPath(path, color: UIColor(hex: "ff0083").colorWithAlphaComponent(0.3))
    
    if includeShadow {
      Draw.addShadow(.Inner, path: path, color: UIColor(white: 0, alpha: 0.3), radius: 20, offset: CGSize(width: 0, height: 5))
    }
    
    if includeBorder {
      Draw.addBorder(.Inner, path: path, color: UIColor(hex: "ff0083"), thickness: 2)
    }
    
    title.drawAlignedTo(rect, attributes: [
      NSForegroundColorAttributeName: UIColor.whiteColor(),
      NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 15)!
    ])
  }
  
  func drawTable(rect: CGRect) {
    let colCount = max(0, min(6, slider.value - 10))
    let rowCount = max(0, min(9, slider.value - 10))
    table = Grid(colCount: Int(colCount), rowCount: Int(rowCount), bounds: rect.insetBy(dx: -1, dy: 0))
    
    let path = table.path(includeComponents: [ .Outline, .Rows, .Columns ])
    Draw.strokePath(path, startColor: UIColor(white: 1, alpha: 0.15), endColor: UIColor(white: 1, alpha: 0.05), angleInDegrees: 90)
    
    drawCell()
  }
  
  func drawNavigationBar(rect: CGRect) {
    if slider.value > 8 {
      Draw.addShadow(.Outer, path: UIBezierPath(rect: rect), color: UIColor(white: 0, alpha: 0.4), radius: 5, offset: CGSize(width: 0, height: 1))
    }
    
    if slider.value > 7 {
      Draw.fillRect(rect, color: UIColor(hex: "ff0083"))
    }
    
    if slider.value > 9 {
      let (_, navFrame) = rect.divide(20, fromEdge: .MinYEdge)
      "InkKit".drawAlignedTo(navFrame, attributes: [
        NSForegroundColorAttributeName: Color.whiteColor(),
        NSFontAttributeName: UIFont(name: "Avenir-Book", size: 20)! ])
    }
    
    if slider.value > 10 {
      backIndicatorImage().drawAtPoint(CGPoint(x: 22, y: 30))
    }
  }
  
  func backIndicatorImage() -> UIImage {
    return Image.draw(width: 12, height: 22, attributes: nil, drawing: { (context, rect, attributes) in
      attributes.lineWidth = 2
      attributes.strokeColor = UIColor.whiteColor()
      
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(CGPointMake(rect.maxX, rect.minY))
      bezierPath.addLineToPoint(CGPointMake(rect.maxX - 10, rect.midY))
      bezierPath.addLineToPoint(CGPointMake(rect.maxX, rect.maxY))
      attributes.apply(bezierPath)
      bezierPath.stroke()
    })
  }
  
}

final class CanvasViewController: UIViewController {
  
  @IBOutlet var canvasView: CanvasView!
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    animate()
  }
  
  func animate() {
    canvasView.slider.value += 1;
    canvasView.setNeedsDisplay()
    
    if canvasView.slider.value == canvasView.slider.maximumValue {
      return
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
      self.animate()
    }
  }
  
}
