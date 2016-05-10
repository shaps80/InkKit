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
    didSet { setNeedsDisplay() }
  }
  
  var horizontalAlignment: HorizontalAlignment = .Center {
    didSet { setNeedsDisplay() }
  }
  
  var verticalAlignment: VerticalAlignment = .Middle {
    didSet { setNeedsDisplay() }
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
    }.drawAtPoint(CGPointMake(10, 10))
    
    let path = UIBezierPath(roundedRect: CGRect(x: leftRect.minX + 50, y: 20, width: 200, height: 100), cornerRadius: 5)
    UIColor.lightGrayColor().setFill()
    path.fill()
    
    Draw.addShadow(.Outer, path: path, color: UIColor.blueColor(), radius: 5, offset: CGSize(width: 0, height: 0))
    Draw.addShadow(.Inner, path: path, color: UIColor.blackColor().colorWithAlphaComponent(0.5), radius: 5, offset: CGSize(width: 0, height: 5))
  
    Draw.strokeLine(CGPoint(x: 0, y: 119.5), endPoint: CGPoint(x: rightRect.maxX, y: 119.5), color: UIColor.blackColor()) { (attributes) in
      attributes.lineWidth = 1
    }
    
    Draw.addBorder(.Outer, path: path) { (attributes) in
      attributes.lineWidth = 6
      attributes.strokeColor = UIColor.whiteColor()
    }
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
