//
//  Borders.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 10/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

public enum BorderType {
  case Inner
  case Outer
  case Center
}

extension Draw {
  
  public static func addStroke(type: BorderType, path: UIBezierPath, attributes attributesBlock: AttributesBlock? = nil) {
    switch type {
    case .Inner:
      addInnerStroke(path, attributes: attributesBlock)
    case .Outer:
      addOuterStroke(path, attributes: attributesBlock)
    case .Center:
      addCenterStroke(path, attributes: attributesBlock)
    }
  }
  
  private static func addInnerStroke(path: UIBezierPath, attributes attributesBlock: AttributesBlock? = nil) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      CGContextClip(context)
      
      CGContextSetLineWidth(context, attributes.lineWidth * 2)
      CGContextAddPath(context, path.CGPath)
      CGContextStrokePath(context)
    }
  }
  
  private static func addOuterStroke(path: UIBezierPath, attributes attributesBlock: AttributesBlock? = nil) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      CGContextSetLineWidth(context, attributes.lineWidth * 2)
      CGContextAddPath(context, path.CGPath)
      CGContextStrokePath(context)
      
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      CGContextEOClip(context)
    }
  }
  
  private static func addCenterStroke(path: UIBezierPath, attributes attributesBlock: AttributesBlock? = nil) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      CGContextStrokePath(context)
    }
  }
  
}
