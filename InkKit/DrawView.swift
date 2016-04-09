//
//  DrawView.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import InkKit

final class DrawView: UIView {
  
  var rotation: CGFloat = 0 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  var horizontalAlignment: HorizontalAlignment = .Center {
    didSet {
      setNeedsDisplay()
    }
  }
  
  var verticalAlignment: VerticalAlignment = .Middle {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setNeedsDisplay()
  }
  
  override func drawRect(frame: CGRect) {
    super.drawRect(frame)
    
    let (leftRect, rightRect) = frame.divide(atDelta: 0.5, fromEdge: .MinXEdge, margin: 10)
    
    let start = UIColor.whiteColor()
    let end = UIColor.cyanColor()
    
    let leftPath = UIBezierPath(rect: leftRect)
    Draw.fillPath(leftPath, startColor: start, endColor: end, angleInDegrees: rotation)
    
    let rightPath = UIBezierPath(rect: rightRect)
    Draw.fillPath(rightPath, startColor: end, endColor: start, angleInDegrees: rotation)
    
    Image(named: "icon")!.drawAlignedTo(leftRect, horizontal: horizontalAlignment, vertical: verticalAlignment)
    "A long string that shoud wrap!".drawAlignedTo(rightRect, horizontal: horizontalAlignment, vertical: verticalAlignment, attributes: attributes(), constrainedSize: CGSizeMake(100, CGFloat.max))
    
    Draw.strokeLine(CGPoint(x: frame.minX, y: 5), endPoint: CGPoint(x: frame.maxX, y: 5), startColor: UIColor.blackColor(), endColor: UIColor.cyanColor(), angleInDegrees: 0) { (attributes) in
      attributes.lineWidth = 2
      attributes.dashPattern = [4, 8]
    }
    
    Image.circle(radius: 10) { (attributes) in
      attributes.strokeColor = UIColor.blackColor()
      attributes.fillColor = UIColor.redColor().colorWithAlphaComponent(0.5)
      attributes.dashPattern = [1, 4]
      attributes.lineWidth = 2
    }.drawAtPoint(CGPointMake(0, 0))
  }
  
  private func attributes() -> [String: AnyObject] {
    let style = NSMutableParagraphStyle()
    style.alignment = .Center
    
    let attributes = [
      NSParagraphStyleAttributeName: style,
      NSFontAttributeName: UIFont.systemFontOfSize(15),
    ]
    
    return attributes
  }
  
}
