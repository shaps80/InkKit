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
  
  public typealias Color = NSColor
  public typealias Image = NSImage
  public typealias BezierPath = NSBezierPath
  public typealias Screen = NSScreen
  public typealias Font = NSFont
  
  func GraphicsContext() -> CGContext? {
    return NSGraphicsContext.current()!.cgContext
  }
  
#else
  
  import UIKit
  public typealias Color = UIColor
  public typealias Image = UIImage
  public typealias EdgeInsets = UIEdgeInsets
  public typealias BezierPath = UIBezierPath
  public typealias Screen = UIScreen
  public typealias Font = UIFont
  
  func GraphicsContext() -> CGContext? {
    return UIGraphicsGetCurrentContext()
  }
  
#endif


/**
 Returns the radian angle value for the specified degrees
 
 - parameter degrees: The angle in degrees to convert
 
 - returns: The angle in radians
 */
public func radians(from degrees: CGFloat) -> CGFloat {
  return degrees * CGFloat(M_PI) / 180
}

#if os(OSX)
  
  extension NSScreen {
    
    public var scale: CGFloat {
      return backingScaleFactor
    }
    
    public static func current() -> Screen {
      return NSScreen.main()!
    }
    
  }
  
#else
  
  extension UIScreen {
   
    public static func current() -> Screen {
      return UIScreen.main()
    }
    
  }
  
#endif


/// Defines a drawing block
public typealias DrawingBlock = @noescape (context: CGContext, rect: CGRect, attributes: DrawingAttributes) -> Void

/// Defines an attributes configuration block
public typealias AttributesBlock = @noescape (attributes: DrawingAttributes) -> Void

/**
 Defines content scaling
 
 - ScaleToFill:     Content is scaled to fill its container
 - ScaleAspectFit:  Content is scaled to fit its container, maintaining its current aspect ratio
 - ScaleAspectFill: Content is scaled to fill its container, maintaining its current aspect ratio
 - Center:          Content is centered inside its container, maintaining its current size and aspect ratio
 */
public enum ScaleMode: Int {
  
  case scaleToFill
  case scaleAspectFit
  case scaleAspectFill
  case center
  
}

/**
 Defines content vertical alignment
 
 - Middle: Content is aligned vertically centered
 - Top:    Content is aligned vertically to the top
 - Bottom: Content is aligned vertically to the bottom
 */
public enum VerticalAlignment : Int {
  
  case middle
  case top
  case bottom
  
}

/**
 Defines content horizontal alignment
 
 - Center: Content is aligned horizontally centered
 - Left:   Content is aligned horizontally to the left
 - Right:  Content is aligned horizontally to the right
 */
public enum HorizontalAlignment : Int {
  
  case center
  case left
  case right
  
}

/// Defines a set of drawing attributes to apply to a drawing operation
public final class DrawingAttributes {
 
  /// The stroke color
  public var strokeColor: Color?
  
  /// The fill color
  public var fillColor: Color?
  
  /// The line width -- defaults to 1
  public var lineWidth: CGFloat = 1
  
  /// The line cap style (defaults to .Round)
  public var lineCap: CGLineCap = .round
  
  /// The line join style (defaults to .Round)
  public var lineJoin: CGLineJoin = .round
  
  /// The line dash pattern
  public var dashPattern: [CGFloat]? = nil
  
  /**
   Applies the attributes to the specified CGContext
   
   - parameter context: The context to apply
   */
  public func apply(to context: CGContext) {
    if let pattern = dashPattern {
      context.setLineDash(phase: 0, lengths: pattern, count: pattern.count)
    }
    
    if let fillColor = fillColor {
      fillColor.setFill()
    }
    
    if let strokeColor = strokeColor {
      strokeColor.setStroke()
    }
    
    context.setLineCap(lineCap)
    context.setLineJoin(lineJoin)
    context.setLineWidth(lineWidth)
  }
  
  /**
   Applies the attributes to the specified Bezier Path
   
   - parameter path: The path to apply
   */
  public func apply(to path: BezierPath) {
    if let pattern = dashPattern {
      path.setLineDash(pattern, count: pattern.count, phase: 0)
    }
    
    if let fillColor = fillColor {
      fillColor.setFill()
    }
    
    if let strokeColor = strokeColor {
      strokeColor.setStroke()
    }
    
    path.lineWidth = lineWidth
    
    #if os(iOS)
      path.lineCapStyle = lineCap
      path.lineJoinStyle = lineJoin
    #else
      path.lineCapStyle = NSLineCapStyle(rawValue: UInt(lineCap.rawValue))!
      path.lineJoinStyle = NSLineJoinStyle(rawValue: UInt(lineJoin.rawValue))!
    #endif
  }
  
}
