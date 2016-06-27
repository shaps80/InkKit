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

/**
 Defines the various border types available
 */
public enum BorderType {
  /// The border will be drawn on the inside of the shapes edge
  case inner
  /// The border will be drawn on the outside of the shapes edge
  case outer
  /// The border will be drawn along the center of the shapes edge
  case center
}

extension Draw {
  
  /**
   Draws a border along the shapes edge
   
   - parameter type:            The type of border to draw
   - parameter path:            The path to apply this border to
   - parameter attributesBlock: Any associated attributes for this drawing
   */
  public static func add(border type: BorderType, path: BezierPath, color: Color? = nil, thickness: CGFloat? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    switch type {
    case .inner:
      addInnerBorder(path, color: color, thickness: thickness, attributes: attributesBlock)
    case .outer:
      addOuterBorder(path, color: color, thickness: thickness, attributes: attributesBlock)
    case .center:
      addCenterBorder(path, color: color, thickness: thickness, attributes: attributesBlock)
    }
  }
  
  private static func addInnerBorder(_ path: BezierPath, color: Color? = nil, thickness: CGFloat? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    GraphicsContext()?.draw(in: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      context.setLineWidth((thickness ?? attributes.lineWidth) * 2)
      color?.setStroke()
      
      context.addPath(path.cgPath)
      
      if !context.isPathEmpty {
       context.clip() 
      }
      
      context.addPath(path.cgPath)
      context.strokePath()
    }
  }
  
  private static func addOuterBorder(_ path: BezierPath, color: Color? = nil, thickness: CGFloat? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    GraphicsContext()?.draw(in: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      context.setLineWidth((thickness ?? attributes.lineWidth) * 2)
      color?.setStroke()
      
      context.addPath(path.cgPath)
      context.strokePath()
      
      context.addPath(path.cgPath)
      context.fillPath()
      
      if !context.isPathEmpty {
        context.eoClip()
      }
    }
  }
  
  private static func addCenterBorder(_ path: BezierPath, color: Color? = nil, thickness: CGFloat? = nil,  attributes attributesBlock: AttributesBlock? = nil) {
    GraphicsContext()?.draw(in: path.bounds, attributes: attributesBlock) { (context, rect, attributes) in
      context.setLineWidth(thickness ?? attributes.lineWidth)
      color?.setStroke()
      
      context.addPath(path.cgPath)
      context.strokePath()
    }
  }
  
}
