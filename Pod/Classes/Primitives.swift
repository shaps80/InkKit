//
//  Primitives.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 06/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

public struct GridComponents : OptionSetType {
  public let rawValue: Int
  public init(rawValue: Int) { self.rawValue = rawValue }
  
  public static var Outline: GridComponents { return GridComponents(rawValue: 1 << 0) }
  public static var Columns: GridComponents { return GridComponents(rawValue: 1 << 1) }
  public static var Rows:    GridComponents { return GridComponents(rawValue: 1 << 2) }
}


extension Draw {
  
  // MARK: Internal functions
  
  static func drawGradientPath(path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, stroke: Bool, attributes attributesBlock: AttributesBlock? = nil) {
    GraphicsContext()?.draw(inRect: path.bounds, attributes: attributesBlock, drawing: { (context, rect, attributes) in
      CGContextAddPath(context, path.CGPath)
      
      if stroke {
        CGContextReplacePathWithStrokedPath(context)
      }
      
      if !CGContextIsPathEmpty(context) {
        CGContextClip(context)
      }
      
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

