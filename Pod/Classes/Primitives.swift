//
//  Primitives.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

extension Draw {
  
  // MARK: Internal functions
  
  static func drawGradientPath(path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, stroke: Bool, attributes attributesBlock: AttributesBlock? = nil) {
    UIGraphicsGetCurrentContext()?.draw(inRect: path.bounds, attributes: attributesBlock, drawing: { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      
      if stroke {
        CGContextReplacePathWithStrokedPath(context)
      }
      
      CGContextClip(context)
      
      let rect = CGPathGetBoundingBox(path.CGPath)
      let locations: [CGFloat] = [0, 1]
      let colorSpace = CGColorSpaceCreateDeviceRGB()
      let colors = [startColor.CGColor, endColor.CGColor]
      let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
      var (start, end) = rect.size.gradientPoints(forAngleInDegrees: angleInDegrees)
      
      start.x += rect.origin.x
      start.y += rect.origin.y
      end.x += rect.origin.x
      end.y += rect.origin.y
      
      CGContextDrawLinearGradient(context, gradient, start, end, [ .DrawsAfterEndLocation, .DrawsBeforeStartLocation ])
    })
  }
  
}

