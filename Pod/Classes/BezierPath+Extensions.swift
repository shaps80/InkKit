/*
  Copyright © 13/05/2016 Shaps

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

import CoreGraphics

#if os(OSX)
  
  import AppKit
  
  public typealias CGPathRef = CGPath

  extension NSBezierPath {
    
    public var cgPath: CGPathRef {
      if self.elementCount == 0 {
        return CGMutablePath()
      }
      
      let path = CGMutablePath()
      var didClosePath = false
      
      for i in 0...self.elementCount-1 {
        var points = [NSPoint](repeating: NSZeroPoint, count: 3)
        
        switch self.element(at: i, associatedPoints: &points) {
        case .moveToBezierPathElement:
          path.moveTo(nil, x: points[0].x, y: points[0].y)
        case .lineToBezierPathElement:
          path.addLineTo(nil, x: points[0].x, y: points[0].y)
        case .curveToBezierPathElement:
          path.addCurve(nil, cp1x: points[0].x, cp1y: points[0].y, cp2x: points[1].x, cp2y: points[1].y, endingAtX: points[2].x, y: points[2].y)
        case .closePathBezierPathElement:
          path.closeSubpath()
          didClosePath = true;
        }
      }
      
      if !didClosePath {
        path.closeSubpath()
      }
      
      return path.copy()!
    }
    
    /**
     Initializes a new NSBezierPath based on the specified CGPath
     
     - parameter CGPath: The CGPath to use for constructing this path
     
     - returns: A new path
     */
    public convenience init(cgPath CGPath: CGPathRef) {
      self.init(rect: CGRect.zero)
      
      CGPath.forEach {
        switch $0.type {
        case .addCurveToPoint:
          curve(to: $0.points[0], controlPoint1: $0.points[1], controlPoint2: $0.points[2])
        case .addLineToPoint:
          line(to: $0.points[0])
        case .addQuadCurveToPoint:
          curve(to: $0.points[0], controlPoint1: $0.points[1], controlPoint2: $0.points[1])
        case .closeSubpath:
          close()
        case .moveToPoint:
          move(to: $0.points[0])
        }
      }
    }
    
    // MARK: iOS Compatibility
    
    /**
     Adds a line to the specified point
     
     - parameter point: The point to add a line to
     */
    public func addLine(to point: CGPoint) {
      line(to: point)
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
  
  extension BezierPath {
    
    @available(*, unavailable, renamed: "cgPath")
    public var CGPath: CGPathRef {
      fatalError()
    }
    
  }
  
#endif

extension CGPath {
  
  /**
   Enumerates over the path elements
   
   - parameter enumerator: The enumeration handler
   */
  public func forEach(_ enumerator: @noescape @convention(block) (CGPathElement) -> Void) {
    typealias ElementEnumeration = @convention(block) (CGPathElement) -> Void
    
    func callback(_ info: UnsafeMutablePointer<Void>?, element: UnsafePointer<CGPathElement>) {
      let enumerator = unsafeBitCast(info, to: ElementEnumeration.self)
      enumerator(element.pointee)
    }
    
    let unsafeBody = unsafeBitCast(enumerator, to: UnsafeMutablePointer<Void>.self)
    self.apply(info: unsafeBody, function: callback)
  }
  
}
