//
//  Shadows.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 10/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

public enum ShadowType {
  case Inner
  case Outer
}

extension Draw {
  
  /**
   Draws a shadow from the specified paths edge
   
   - parameter type:   The type of shadow to draw
   - parameter path:   The path to apply this shadow to
   - parameter color:  The color for this shadow -- opacity is controlled through the color's opacity
   - parameter radius: The blur radius of this shadow
   - parameter offset: The offest of this shadow
   */
  public static func addShadow(type: ShadowType, path: BezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    switch type {
    case .Inner:
      addInnerShadow(path, color: color, radius: radius, offset: offset)
    case .Outer:
      addOuterShadow(path, color: color, radius: radius, offset: offset)
    }
  }
  
  private static func addInnerShadow(path: BezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    GraphicsContext()?.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      
      if !CGContextIsPathEmpty(context) {
        CGContextClip(context)
      }
      
      let opaqueShadowColor = CGColorCreateCopyWithAlpha(color.CGColor, 1.0)
      
      CGContextSetAlpha(context, CGColorGetAlpha(color.CGColor))
      CGContextBeginTransparencyLayer(context, nil)
      CGContextSetShadowWithColor(context, offset, radius, opaqueShadowColor)
      CGContextSetBlendMode(context, .SourceOut)
      CGContextSetFillColorWithColor(context, opaqueShadowColor!)
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      CGContextEndTransparencyLayer(context)
    }
  }
  
  private static func addOuterShadow(path: BezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    GraphicsContext()?.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      CGContextBeginTransparencyLayer(context, nil)
      CGContextSetShadowWithColor(context, offset, radius, color.CGColor)
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      CGContextEndTransparencyLayer(context)
    }
  }

}
