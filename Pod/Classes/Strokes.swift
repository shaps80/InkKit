//
//  Strokes.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 10/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

extension Draw {
  
  /**
   Strokes a line from startPoint to endPoint with a gradient. Note: The following is valid -- endPoint.x < startPoint.x || endPoint.y < startPoint.y
   
   - parameter startPoint:      The startpoint for this line
   - parameter endPoint:        The endpoint for this line
   - parameter startColor:      The start color for the gradient
   - parameter endColor:        The end color for the gradient
   - parameter angleInDegrees:  The angle (in degrees) of the gradient for this line
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokeLine(startPoint: CGPoint, endPoint: CGPoint, startColor: Color, endColor: Color, angleInDegrees: CGFloat = 0, attributes attributesBlock: AttributesBlock? = nil) {
    let path = BezierPath()
    path.moveToPoint(startPoint)
    path.addLineToPoint(endPoint)
    drawGradientPath(path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, stroke: true, attributes: attributesBlock)
  }
  
  /**
   Strokes the specified path
   
   - parameter path:            The path to stroke
   - parameter startColor:      The start color for the gradient
   - parameter endColor:        The end color for the gradient
   - parameter angleInDegrees:  The angle (in degrees) of the gradient
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokePath(path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, attributes attributesBlock: AttributesBlock? = nil) {
    drawGradientPath(path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, stroke: true, attributes: attributesBlock)
  }
  
  /**
   Strokes a line from startPoint to endPoint with a single color (optimized). Note: The following is valid -- endPoint.x < startPoint.x || endPoint.y < startPoint.y
   
   - parameter startPoint:      The start point for this line
   - parameter endPoint:        The end point for this line
   - parameter color:           The color for this line
   - parameter attributesBlock: Any additional attributes can be configured using this configuration block
   */
  public static func strokeLine(startPoint: CGPoint, endPoint: CGPoint, color: Color = Color.blackColor(), attributes attributesBlock: AttributesBlock? = nil) {
    let rect = reversibleRect(fromPoint: startPoint, toPoint: endPoint)
    
    UIGraphicsGetCurrentContext()?.draw(inRect: rect, attributes: attributesBlock, drawing: { (context, rect, attributes) in
      color.setStroke()
      CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5)
      CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5)
      CGContextStrokePath(context)
    })
  }
  
}
