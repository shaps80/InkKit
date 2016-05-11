//
//  Borders.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 10/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

/**
 Defines the various border types available
 
 - Inner:  The border will be drawn on the inside of the shapes edge
 - Outer:  The border will be drawn on the outside of the shapes edge
 - Center: The border will be drawn along the center of the shapes edge
 */
public enum BorderType {
  case Inner
  case Outer
  case Center
}

extension Draw {
  
  /**
   Draws a border along the shapes edge
   
   - parameter type:            The type of border to draw
   - parameter path:            The path to apply this border to
   - parameter attributesBlock: Any associated attributes for this drawing
   */
  public static func addBorder(type: BorderType, path: BezierPath, color: UIColor? = nil, thickness: CGFloat? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    switch type {
    case .Inner:
      addInnerBorder(path, color: color, thickness: thickness, attributes: attributesBlock)
    case .Outer:
      addOuterBorder(path, color: color, thickness: thickness, attributes: attributesBlock)
    case .Center:
      addCenterBorder(path, color: color, thickness: thickness, attributes: attributesBlock)
    }
  }
  
  private static func addInnerBorder(path: BezierPath, color: UIColor? = nil, thickness: CGFloat? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      CGContextSetLineWidth(context, (thickness ?? attributes.lineWidth) * 2)
      color?.setStroke()
      
      CGContextAddPath(context, path.CGPath)
      
      if !CGContextIsPathEmpty(context) {
       CGContextClip(context) 
      }
      
      CGContextAddPath(context, path.CGPath)
      CGContextStrokePath(context)
    }
  }
  
  private static func addOuterBorder(path: BezierPath, color: UIColor? = nil, thickness: CGFloat? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      CGContextSetLineWidth(context, (thickness ?? attributes.lineWidth) * 2)
      color?.setStroke()
      
      CGContextAddPath(context, path.CGPath)
      CGContextStrokePath(context)
      
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      
      if !CGContextIsPathEmpty(context) {
        CGContextEOClip(context)
      }
    }
  }
  
  private static func addCenterBorder(path: BezierPath, color: UIColor? = nil, thickness: CGFloat? = nil,  attributes attributesBlock: AttributesBlock? = nil) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      CGContextSetLineWidth(context, thickness ?? attributes.lineWidth)
      color?.setStroke()
      
      CGContextAddPath(context, path.CGPath)
      CGContextStrokePath(context)
    }
  }
  
}
