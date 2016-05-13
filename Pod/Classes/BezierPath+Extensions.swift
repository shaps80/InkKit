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
    
    var CGPath: CGPathRef {
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
    
    public func addLineToPoint(point: CGPoint) {
      lineToPoint(point)
    }
    
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
    
  }
  
#endif

extension CGPath {
  
  func forEach(@noescape body: @convention(block) (CGPathElement) -> Void) {
    typealias Body = @convention(block) (CGPathElement) -> Void
    
    func callback(info: UnsafeMutablePointer<Void>, element: UnsafePointer<CGPathElement>) {
      let body = unsafeBitCast(info, Body.self)
      body(element.memory)
    }
    
    let unsafeBody = unsafeBitCast(body, UnsafeMutablePointer<Void>.self)
    CGPathApply(self, unsafeBody, callback)
  }
  
}



