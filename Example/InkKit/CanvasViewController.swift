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

import UIKit
import InkKit

final class CanvasView: UIView {
  
  private var table: Grid!
  @IBOutlet var slider: UISlider!
  
  @IBAction func valueChanged(_ slider: UISlider) {
    setNeedsDisplay()
  }
  
  override func draw(_ bgFrame: CGRect) {
    super.draw(bgFrame)
    Draw.fillRect(bgFrame, color: Color(hex: "1c3d64"))
    
    
    drawAnimatedFrames(bgFrame)
    
    /*
     The commented code below, is ALL that is actually required to render to final UI.
     
     If you uncomment it to see the result, don't forget to comment the drawAnimatedFrames() call above this comment.
     */
    
    
//    let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
//    let navBarHeight: CGFloat = 44
//    
//    let margin: CGFloat = 0
//    let topGuide = statusBarHeight + navBarHeight
//    let barFrame = CGRect(x: 0, y: 0, width: bgFrame.width, height: topGuide)
//    let tableFrame = CGRect(x: 0, y: barFrame.maxY + margin, width: bgFrame.width, height: bgFrame.maxY - barFrame.height)
//    
//    
//    // Table
//    
//    let grid = Grid(colCount: 6, rowCount: 9, bounds: tableFrame)
//    let path = grid.path(includeComponents: [.Columns, .Rows])
//    
//    Draw.strokePath(path, startColor: Color(white: 1, alpha: 0.15), endColor: Color(white: 1, alpha: 0.05), angleInDegrees: 90)
//    
//    // Cell
//    
//    let rect = grid.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 4, destinationRow: 6)
//    drawCell(rect, title: "4x6", includeBorder: true, includeShadow: true)
//    
//    // Navigation Bar
//    
//    Draw.addShadow(.Outer, path: BezierPath(rect: barFrame), color: Color(white: 0, alpha: 0.4), radius: 5, offset: CGSize(width: 0, height: 1))
//    Draw.fillRect(barFrame, color: Color(hex: "ff0083"))
//    
//    let (_, navFrame) = barFrame.divide(20, fromEdge: .MinYEdge)
//    "InkKit".drawAlignedTo(navFrame, attributes: [
//      NSForegroundColorAttributeName: Color.whiteColor(),
//      NSFontAttributeName: Font(name: "Avenir-Book", size: 20)! ])
//    
//    backIndicatorImage().drawAtPoint(CGPoint(x: 22, y: 30))
  }
  
  func drawAnimatedFrames(_ bgFrame: CGRect) {
    let statusBarHeight: CGFloat = UIApplication.shared().statusBarFrame.height
    let navBarHeight: CGFloat = 44
    
    let margin: CGFloat = 0
    let topGuide = statusBarHeight + navBarHeight
    let barFrame = CGRect(x: 0, y: 0, width: bgFrame.width, height: topGuide)
    let tableFrame = CGRect(x: 0, y: barFrame.maxY + margin, width: bgFrame.width, height: bgFrame.maxY - barFrame.height)
    
    if slider.value < 5 {
      drawPlaceholder(bgFrame)
    }
    
    if slider.value >= 11 {
      drawTable(tableFrame)
    }
    
    if slider.value >= 6 {
      drawNavigationBar(barFrame)
    }
    
    if slider.value > 27 {
      slider.isHidden = false
    }
  }
  
  func drawPlaceholder(_ rect: CGRect) {
    "InkKit".drawAlignedTo(rect, attributes: [
      NSForegroundColorAttributeName: Color.white(),
      NSFontAttributeName: Font(name: "Avenir-Book", size: 60)!
    ])
  }
  
  func drawCell() {
    if slider.value > 20 && slider.value < 21 {
      let rect = table.boundsForCell	(col: 1, row: 1)
      drawCell(rect, title: "1x1")
    }
    
    if slider.value >= 21 && slider.value < 22 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 1)
      drawCell(rect, title: "2x1")
    } else
    
    if slider.value >= 22 && slider.value < 23 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 2)
      drawCell(rect, title: "2x2")
    }
    
    if slider.value >= 23 && slider.value < 24 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 2)
      drawCell(rect, title: "2x2", includeBorder: true, includeShadow: false)
    }
    
    if slider.value >= 24 && slider.value < 25 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 2, destinationRow: 2)
      drawCell(rect, title: "2x2", includeBorder: true, includeShadow: true)
    }
    
    if slider.value >= 25 && slider.value < 26 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 4, destinationRow: 2)
      drawCell(rect, title: "4x2", includeBorder: true, includeShadow: true)
    }
    
    if slider.value >= 26 {
      let rect = table.boundsForRange(sourceColumn: 1, sourceRow: 1, destinationColumn: 4, destinationRow: 6)
      drawCell(rect, title: "4x6", includeBorder: true, includeShadow: true)
    }
  }
  
  func drawCell(_ rect: CGRect, title: String, includeBorder: Bool = false, includeShadow: Bool = false) {
    let path = BezierPath(roundedRect: rect, cornerRadius: 4)
    
    Draw.fillPath(path, color: Color(hex: "ff0083").withAlphaComponent(0.3))
    
    if includeShadow {
      Draw.addShadow(.inner, path: path, color: Color(white: 0, alpha: 0.3), radius: 20, offset: CGSize(width: 0, height: 5))
    }
    
    if includeBorder {
      Draw.addBorder(.inner, path: path, color: Color(hex: "ff0083"), thickness: 2)
    }
    
    title.drawAlignedTo(rect, attributes: [
      NSForegroundColorAttributeName: Color.white(),
      NSFontAttributeName: Font(name: "Avenir-Medium", size: 15)!
    ])
  }
  
  func drawTable(_ rect: CGRect) {
    let colCount = max(0, min(6, slider.value - 10))
    let rowCount = max(0, min(9, slider.value - 10))
    table = Grid(colCount: Int(colCount), rowCount: Int(rowCount), bounds: rect.insetBy(dx: -1, dy: 0))
    
    let path = table.path(includeComponents: [ .Outline, .Rows, .Columns ])
    Draw.strokePath(path, startColor: Color(white: 1, alpha: 0.15), endColor: Color(white: 1, alpha: 0.05), angleInDegrees: 90)
    
    drawCell()
  }
  
  func drawNavigationBar(_ rect: CGRect) {
    if slider.value > 8 {
      Draw.addShadow(.outer, path: BezierPath(rect: rect), color: Color(white: 0, alpha: 0.4), radius: 5, offset: CGSize(width: 0, height: 1))
    }
    
    if slider.value > 7 {
      Draw.fillRect(rect, color: Color(hex: "ff0083"))
    }
    
    if slider.value > 9 {
      let (_, navFrame) = rect.divide(20, fromEdge: .minYEdge)
      "InkKit".drawAlignedTo(navFrame, attributes: [
        NSForegroundColorAttributeName: Color.white(),
        NSFontAttributeName: Font(name: "Avenir-Book", size: 20)! ])
    }
    
    if slider.value > 10 {
      backIndicatorImage().draw(at: CGPoint(x: 22, y: 30))
    }
  }
  
  func backIndicatorImage() -> Image {
    return Image.draw(width: 12, height: 22, attributes: nil, drawing: { (context, rect, attributes) in
      attributes.lineWidth = 2
      attributes.strokeColor = Color.white()
      
      let bezierPath = BezierPath()
      bezierPath.move(to: CGPoint(x: rect.maxX, y: rect.minY))
      bezierPath.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY))
      bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      attributes.apply(bezierPath)
      bezierPath.stroke()
    })
  }
  
}

final class CanvasViewController: UIViewController {
  
  @IBOutlet var canvasView: CanvasView!
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animate()
  }
  
  func animate() {
    canvasView.slider.value += 1;
    canvasView.setNeedsDisplay()
    
    if canvasView.slider.value == canvasView.slider.maximumValue {
      return
    }
    
    DispatchQueue.main.after(when: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
      self.animate()
    }
  }
  
}
