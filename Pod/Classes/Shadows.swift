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
  
  public static func addShadow(type: ShadowType, path: UIBezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    switch type {
    case .Inner:
      addInnerShadow(path, color: color, radius: radius, offset: offset)
    case .Outer:
      addOuterShadow(path, color: color, radius: radius, offset: offset)
    }
  }
  
  private static func addInnerShadow(path: UIBezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      CGContextClip(context)
      
      let opaqueShadowColor = CGColorCreateCopyWithAlpha(color.CGColor, 1.0)
      
      CGContextSetAlpha(context, CGColorGetAlpha(color.CGColor))
      CGContextBeginTransparencyLayer(context, nil)
      CGContextSetShadowWithColor(context, offset, radius, opaqueShadowColor)
      CGContextSetBlendMode(context, .SourceOut)
      CGContextSetFillColorWithColor(context, opaqueShadowColor)
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      CGContextEndTransparencyLayer(context)
    }
  }
  
  private static func addOuterShadow(path: UIBezierPath, color: Color, radius: CGFloat, offset: CGSize) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: nil) { (context, rect, attributes) in
      let opaqueShadowColor = CGColorCreateCopyWithAlpha(color.CGColor, 1.0)
      
      CGContextBeginTransparencyLayer(context, nil)
      CGContextSetShadowWithColor(context, offset, radius, color.CGColor)
      CGContextAddPath(context, path.CGPath)
      CGContextFillPath(context)
      CGContextEndTransparencyLayer(context)
    }
  }

}
