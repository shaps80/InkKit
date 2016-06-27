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

extension Image {
  
  /**
   Returns the current image with a tintColor applied, using the specified blend mode
   
   - parameter color:     The tint color to apply
   - parameter blendMode: The blend mode to apply for this tint
   
   - returns: The tinted image
   */
  public func with(tint color: UIColor, blendMode: CGBlendMode = .color) -> UIImage {
    return Image.draw(size: size, attributes: nil) { (context, rect, attributes) in
      context.translate(x: 0, y: self.size.height)
      context.scale(x: 1.0, y: -1.0)
      
      context.setBlendMode(blendMode)
      color.setFill()
      context.fill(rect)
      context.setBlendMode(.destinationIn)
      
      if let image = self.cgImage {
        context.draw(in: rect, image: image)
      }
    }
  }
  
  /**
   Returns an image representing a cirle. To modify its color, stroke, etc... use the attributesBlock
   
   - parameter radius:          The radius of the cirle to draw
   - parameter attributesBlock: The attributes configuration block
   
   - returns: An image of a circle
   */
  public static func circle(radius: CGFloat, attributes attributesBlock: AttributesBlock) -> Image {
    return Image.draw(width: radius * 2, height: radius * 2, attributes: attributesBlock, drawing: { (context, rect, attributes) in
      let path = BezierPath(ovalIn: rect.insetBy(dx: 1, dy: 1))
      attributes.apply(to: path)
      path.fill()
      path.stroke()
    })
  }
  
  /**
   Draws the current image, aligned to the specified rect
   
   - parameter rect:       The rect to align to
   - parameter horizontal: The horizontal alignment
   - parameter vertical:   The vertical alignment
   - parameter blendMode:  The blend mode to apply to this drawing
   - parameter alpha:      The alpha to apply to this drawing
   */
  public func draw(alignedTo rect: CGRect, horizontal: HorizontalAlignment = .center, vertical: VerticalAlignment = .middle, blendMode: CGBlendMode = .sourceOut, alpha: CGFloat = 1) {
    let alignedRect = CGRect(x: 0, y: 0, width: size.width, height: size.height).aligned(to: rect, horizontal: horizontal, vertical: vertical)
    let fromRect = CGRect(x: 0, y: 0, width: alignedRect.width, height: alignedRect.height)
    ink_drawInRect(alignedRect, fromRect: fromRect, blendMode: blendMode, alpha: alpha)
  }
  
  /**
   Draws the current image, scaled to the specified rect
   
   - parameter rect:      The rect to scale to
   - parameter mode:      The scale mode to use
   - parameter blendMode: The blend mode to apply to this drawing
   - parameter alpha:     The alpha to apply to this drawing
   */
  public func draw(scaledTo rect: CGRect, scaleMode: ScaleMode, blendMode: CGBlendMode = .sourceOut, alpha: CGFloat = 1) {
    let scaledRect = CGRect(x: 0, y: 0, width: size.width, height: size.height).scaled(to: rect, scaleMode: scaleMode)
    let fromRect = CGRect(x: 0, y: 0, width: scaledRect.width, height: scaledRect.height)
    ink_drawInRect(scaledRect, fromRect: fromRect, blendMode: blendMode, alpha: alpha)
  }
  
  private func ink_drawInRect(_ rect: CGRect, fromRect: CGRect, blendMode mode: CGBlendMode, alpha: CGFloat) {
    #if os(iOS)
      draw(in: rect, blendMode: mode, alpha: alpha)
    #else
      draw(in: rect, from: fromRect, operation: NSCompositingOperation(rawValue: UInt(mode.rawValue))!, fraction: alpha)
    #endif
  }
  
  // MARK: OSX Compatibility
  
  #if os(OSX)
  
  /**
   Draws the image at the specified point
   
   - parameter point: The point to position this image's origin
   */
  public func draw(at point: CGPoint) {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    draw(at: point, from: rect, operation: .sourceOut, fraction: 1.0)
  }
  
  #endif
  
}

extension Image {
  
  /**
   Returns an image using the drawingBlock provided
   
   - parameter width:   The width of the image to return
   - parameter height:  The height of the image to return
   - parameter scale:   The scale of the image to return
   - parameter attributesBlock: The attributes configuration block
   - parameter drawing: The drawing operations to perform on this image
   
   - returns: A new image
   */
  public static func draw(width: CGFloat, height: CGFloat, scale: CGFloat = Screen.current().scale, attributes attributesBlock: AttributesBlock?, drawing: DrawingBlock) -> Image {
    return draw(size: CGSize(width: width, height: height), attributes: attributesBlock, drawing: drawing)
  }
  
  /**
   Returns an image using the drawingBlock provided
   
   - parameter size:    The size of the image to return
   - parameter scale:   The scale of the image to return
   - parameter attributesBlock: The attributes configuration block
   - parameter drawing: The drawing operations to perform on this image
   
   - returns: A new image
   */
  public static func draw(size: CGSize, scale: CGFloat = Screen.current().scale, attributes attributesBlock: AttributesBlock?, drawing: DrawingBlock) -> Image {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    
    #if os(OSX)
      let image = Image(size: size)
      image.lockFocus()
      GraphicsContext()?.draw(in: rect, attributes: attributesBlock, drawing: drawing)
      image.unlockFocus()
      return image
    #else
      UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height), false, scale)
      GraphicsContext()?.draw(in: rect, attributes: attributesBlock, drawing: drawing)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return image!
    #endif
  }
  
}
