//
//  BezierPath+Extensions.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 07/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

#if os(OSX)
  
  import AppKit

  extension NSBezierPath {
    
    /// Returns a CGPath representation of the bezier path
    public var CGPath: CGPathRef {
      if self.elementCount == 0 {
        return CGPathCreateMutable()
      }
      
      let path = CGPathCreateMutable()
      var didClosePath = false
      
      for i in 0...self.elementCount-1 {
        var points = [NSPoint](count: 3, repeatedValue: NSZeroPoint)
        
        switch self.elementAtIndex(i, associatedPoints: &points) {
        case .MoveToBezierPathElement:
          CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
        case .LineToBezierPathElement:
          CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
        case .CurveToBezierPathElement:
          CGPathAddCurveToPoint(path, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y)
        case .ClosePathBezierPathElement:
          CGPathCloseSubpath(path)
          didClosePath = true;
        }
      }
      
      if !didClosePath {
        CGPathCloseSubpath(path)
      }
      
      return CGPathCreateCopy(path)!
    }
    
    /**
     Initializes a new NSBezierPath based on the specified CGPath
     
     - parameter CGPath: The CGPath to use for constructing this path
     
     - returns: A new path
     */
    public convenience init(CGPath: CGPathRef) {
      self.init(rect: CGRectZero)
      
      CGPath.forEach {
        switch $0.type {
        case .AddCurveToPoint:
          curveToPoint($0.points[0], controlPoint1: $0.points[1], controlPoint2: $0.points[2])
        case .AddLineToPoint:
          lineToPoint($0.points[0])
        case .AddQuadCurveToPoint:
          curveToPoint($0.points[0], controlPoint1: $0.points[1], controlPoint2: $0.points[1])
        case .CloseSubpath:
          closePath()
        case .MoveToPoint:
          moveToPoint($0.points[0])
        }
      }
    }
    
    // MARK: iOS Compatibility
    
    /**
     Adds a line to the specified point
     
     - parameter point: The point to add a line to
     */
    public func addLineToPoint(point: CGPoint) {
      lineToPoint(point)
    }
    
    /**
     Initializes a new path with rounded corners
     
     - parameter rect:         The rect to use for this path
     - parameter cornerRadius: The corner radius to apply to this path
     
     - returns: A new path
     */
    public convenience init(roundedRect rect: CGRect, cornerRadius: CGFloat) {
      self.init(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
    }
    
  }
  
#endif

extension CGPath {
  
  /**
   Enumerates over the path elements
   
   - parameter enumerator: The enumeration handler
   */
  public func forEach(@noescape enumerator: @convention(block) (CGPathElement) -> Void) {
    typealias ElementEnumeration = @convention(block) (CGPathElement) -> Void
    
    func callback(info: UnsafeMutablePointer<Void>, element: UnsafePointer<CGPathElement>) {
      let enumerator = unsafeBitCast(info, ElementEnumeration.self)
      enumerator(element.memory)
    }
    
    let unsafeBody = unsafeBitCast(enumerator, UnsafeMutablePointer<Void>.self)
    CGPathApply(self, unsafeBody, callback)
  }
  
}



