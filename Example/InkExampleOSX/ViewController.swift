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

import Cocoa
import InkKit
import GraphicsRenderer

class ViewController: NSViewController { }

final class CanvasView: NSView {

  override var isFlipped: Bool {
    return true
  }

  
  // Shadow -- add replaced with draw
  // Draw -- replaced with context instance
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
    let bgFrame = dirtyRect
    let titleBarHeight: CGFloat = 44
    
    let margin: CGFloat = 0
    let topGuide = titleBarHeight
    let barFrame = CGRect(x: 0, y: 0, width: bgFrame.width, height: topGuide)
    let tableFrame = CGRect(x: 0, y: barFrame.maxY + margin, width: bgFrame.width, height: bgFrame.maxY - barFrame.height)
    
    guard let context = CGContext.current else { return }
    
    context.fill(rect: bgFrame, color: Color(hex: "1c3d64")!)
    
    // Table
    
    let grid = InkKit.Grid(colCount: 6, rowCount: 9, bounds: tableFrame)
    let path = grid.path(include: [.columns, .rows])
    
    context.stroke(path: path, startColor: Color(white: 1, alpha: 0.15), endColor: Color(white: 1, alpha: 0.05), angleInDegrees: 90)
    
    // Cell
    
    let rect = grid.boundsForRange(sourceColumn: 2, sourceRow: 3, destinationColumn: 4, destinationRow: 6)
    drawCell(in: rect, title: "4x6", includeBorder: true, includeShadow: true)
    
    // Navigation Bar
    
    context.draw(shadow: .outer, path: BezierPath(rect: barFrame), color: Color(white: 0, alpha: 0.4), radius: 5, offset: CGSize(width: 0, height: 1))
    context.fill(rect: barFrame, color: Color(hex: "ff0083")!)
    
    "InkKit".drawAligned(to: barFrame, attributes: [
      NSAttributedStringKey.foregroundColor: Color.white.nsColor,
      NSAttributedStringKey.font: Font(name: "Avenir-Book", size: 20)! ])
    
    backIndicatorImage().draw(in: CGRect(x: 20, y: 11, width: 12, height: 22))
    
    grid.enumerateCells { (index, col, row, bounds) in
      "\(index)".drawAligned(to: bounds, attributes: [
        NSAttributedStringKey.font: Font(name: "Avenir-Book", size: 12)!,
        NSAttributedStringKey.foregroundColor: Color(white: 1, alpha: 0.5).nsColor
      ])
    }
    
    drawInnerGrid(in: grid.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 1, destinationRow: 1))
  }

  func drawInnerGrid(in bounds: CGRect) {
    let grid = InkKit.Grid(colCount: 3, rowCount: 3, bounds: bounds)
    let path = grid.path(include: [ .outline, .columns, .rows ])
    
    Color.white.setStroke()
    path.stroke()
  }
  
  func drawCell(in bounds: CGRect, title: String, includeBorder: Bool = false, includeShadow: Bool = false) {
    guard let context = CGContext.current else { return }
    let path = BezierPath(roundedRect: bounds, cornerRadius: 4)
    
    context.fill(path: path, color: Color(hex: "ff0083")!.with(alpha: 0.3))
    
    if includeShadow {
      context.draw(shadow: .inner, path: path, color: Color(white: 0, alpha: 0.3), radius: 20, offset: CGSize(width: 0, height: 5))
    }
    
    if includeBorder {
      context.stroke(border: .inner, path: path, color: Color(hex: "ff0083")!, thickness: 2)
    }
    
    title.drawAligned(to: bounds, attributes: [
      NSAttributedStringKey.foregroundColor: Color.white.nsColor,
      NSAttributedStringKey.font: Font(name: "Avenir-Medium", size: 15)!
    ])
  }
  
  func backIndicatorImage() -> Image {
    return Image.draw(width: 12, height: 22, attributes: nil, drawing: { (context, rect, attributes) in
      attributes.lineWidth = 2
      attributes.strokeColor = Color.white
      
      let bezierPath = BezierPath()
      bezierPath.move(to: CGPoint(x: rect.maxX, y: rect.minY))
      bezierPath.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY))
      bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      attributes.apply(to: bezierPath)
      bezierPath.stroke()
    })
  }
  
}
