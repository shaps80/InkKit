//
//  Deprecations.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 20/06/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

@available(*, unavailable, renamed:"Grid")
public struct Table { }

@available(*, unavailable, renamed:"GridComponents")
public struct TableComponents { }

@available(*, unavailable, renamed: "radians(from:)")
public func radians(fromDegrees degrees: CGFloat) -> CGFloat {
  return radians(from: degrees)
}

extension UIScreen {
  
  @available(*, unavailable, renamed: "current")
  public static func currentScreen() -> Screen {
    return current()
  }
  
}

extension DrawingAttributes {
  
  @available(*, unavailable, renamed: "apply(to:)")
  public func apply(_ context: CGContext) {
    apply(to: context)
  }
  
  @available(*, unavailable, renamed: "apply(to:)")
  public func apply(_ path: BezierPath) {
    apply(to: path)
  }
  
}

extension GridComponents {
  
  @available(*, unavailable, renamed: "outline")
  public static var Outline: GridComponents { return .outline }
  
  @available(*, unavailable, renamed: "columns")
  public static var Columns: GridComponents { return .columns }
  
  @available(*, unavailable, renamed: "rows")
  public static var Rows:    GridComponents { return .rows }
  
  @available(*, unavailable, renamed: "all")
  public static var All:     GridComponents { return [ .outline, .columns, .rows ] }
}

extension String {
  
  @available(*, unavailable, renamed: "draw(alignedTo:horizontal:vertical:constrainedSize:attributes:)")
  public func drawAlignedTo(_ rect: CGRect, horizontal: HorizontalAlignment = .center, vertical: VerticalAlignment = .middle, attributes: [String: AnyObject]?, constrainedSize: CGSize? = nil) {
    draw(alignedTo: rect, horizontal: horizontal, vertical: vertical, constrainedSize: constrainedSize, attributes: attributes)
  }
  
  @available(*, unavailable, renamed: "sizeWith(constrainedSize:)")
  public func sizeWithAttributes(_ attributes: [String : AnyObject]?, constrainedSize: CGSize? = nil) -> CGSize {
    return sizeWith(attributes: attributes, constrainedSize: constrainedSize)
  }
  
  @available(*, unavailable, renamed: "draw(at:attributes:)")
  public func drawAtPoint(_ point: CGPoint, withAttributes attributes: [String : AnyObject]?)  {
    draw(at: point, attributes: attributes)
  }
  
  @available(*, unavailable, renamed: "draw(in:attributes:)")
  public func drawInRect(_ rect: CGRect, withAttributes attributes: [String : AnyObject]?) {
    draw(in: rect, attributes: attributes)
  }
  
}

extension Image {
  
  @available(*, unavailable, renamed: "circle(radius:attributes:)")
  public static func circle(_ radius: CGFloat, attributes attributesBlock: AttributesBlock) -> Image {
    return circle(radius: radius, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "draw(alignedTo:horizontal:vertical:blendMode:alpha:)")
  public func drawAlignedTo(_ rect: CGRect, horizontal: HorizontalAlignment = .center, vertical: VerticalAlignment = .middle, blendMode: CGBlendMode = .normal, alpha: CGFloat = 1.0) {
    draw(alignedTo: rect, horizontal: horizontal, vertical: vertical, blendMode: blendMode, alpha: alpha)
  }
  
  @available(*, unavailable, renamed: "draw(scaledTo:scaleMode:blendMode:alpha:)")
  public func drawScaledTo(_ rect: CGRect, scaleMode mode: ScaleMode, blendMode: CGBlendMode = .sourceOut, alpha: CGFloat = 1) {
    draw(scaledTo: rect, scaleMode: mode, blendMode: blendMode, alpha: alpha)
  }
  
  @available(*, unavailable, renamed: "draw(at:)")
  public func drawAtPoint(point: CGPoint) {
    draw(at: point)
  }
  
}

extension Grid {
  
  @available(*, unavailable, renamed: "positionForCell(at:)")
  public func positionForCell(atIndex index: Int) -> (col: Int, row: Int) {
    return positionForCell(at: index)
  }
  
  @available(*, unavailable, renamed: "boundsForCell(at:)")
  public func boundsForCell(atIndex index: Int) -> CGRect {
    return boundsForCell(at: index)
  }
  
  @available(*, unavailable, renamed: "path(includeComponents:)")
  public func path(includeComponents components: GridComponents) -> BezierPath {
    return path(include: components)
  }
  
}

extension CGRect {
  
  public func divide(atDelta delta: CGFloat, fromEdge edge: CGRectEdge, margin: CGFloat = 0) -> (slice: CGRect, remainder: CGRect) {
    return divide(at: delta, from: edge, margin: margin)
  }
  
  
  @available(*, unavailable, renamed: "inset(by:)")
  public func insetBy(_ edgeInsets: EdgeInsets) -> CGRect {
    return inset(by: edgeInsets)
  }
  
  @available(*, unavailable, renamed: "insetInPlace(by:)")
  public mutating func insetInPlace(_ edgeInsets: EdgeInsets) {
    insetInPlace(by: edgeInsets)
  }
  
  @available(*, unavailable, renamed: "aligned(to:horizontal:vertical:)")
  public func alignedTo(_ rect: CGRect, horizontal: HorizontalAlignment, vertical: VerticalAlignment) -> CGRect {
    return aligned(to: rect, horizontal: horizontal, vertical: vertical)
  }
  
  @available(*, unavailable, renamed: "scaled(to:mode:)")
  public func scaledTo(_ rect: CGRect, scaleMode mode: ScaleMode) -> CGRect {
    return scaled(to: rect, scaleMode: mode)
  }
  
}

extension CGSize {
  
  @available(*, unavailable, renamed: "scaled(to:mode:)")
  public func scaledTo(_ size: CGSize, scaleMode mode: ScaleMode) -> CGSize {
    return scaled(to: size, mode: mode)
  }
  
}

public class Draw {
  
  @available(*, unavailable, renamed: "add(border:path:color:thickness:attributes:)")
  public static func addBorder(_ type: BorderType, path: BezierPath, color: Color? = nil, thickness: CGFloat? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    add(border: type, path: path, color: color, thickness: thickness, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "strokeLine(from:to:color:attributes:)")
  public static func strokeLine(_ startPoint: CGPoint, endPoint: CGPoint, color: Color? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    strokeLine(from: startPoint, to: endPoint, color: color, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "stroke(path:startColor:endColor:angleInDegrees:attributes:)")
  public static func strokePath(_ path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, attributes attributesBlock: AttributesBlock? = nil) {
    stroke(path: path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "strokeLine(from:to:startColor:endColor:angleInDegrees:attributes:)")
  public static func strokeLine(_ startPoint: CGPoint, endPoint: CGPoint, startColor: Color, endColor: Color, angleInDegrees: CGFloat = 0, attributes attributesBlock: AttributesBlock? = nil) {
    strokeLine(from: startPoint, to: endPoint, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "stroke(path:color:attributes:)")
  public static func strokePath(_ path: BezierPath, color: Color, attributes attributesBlock: AttributesBlock? = nil) {
    stroke(path: path, color: color, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "stroke(rect:startColor:endColor:angleInDegrees:attributes:)")
  public static func strokeRect(_ rect: CGRect, startColor: Color, endColor: Color, angleInDegrees: CGFloat, attributes attributesBlock: AttributesBlock? = nil) {
    stroke(rect: rect, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "stroke(rect:color:attributes:)")
  public static func strokeRect(_ rect: CGRect, color: Color? = nil, attributes attributesBlock: AttributesBlock? = nil) {
    stroke(rect: rect, color: color, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "add(shadow:path:color:radius:offset:)")
  public static func addShadow(_ type: ShadowType, path: BezierPath, color: Color, radius: CGFloat, offset shadowOffset: CGSize) {
    add(shadow: type, path: path, color: color, radius: radius, offset: shadowOffset)
  }
  
  @available(*, unavailable, renamed: "fill(path:startColor:endColor:angleInDegrees:attributes:)")
  public static func fillPath(_ path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, attributes attributesBlock: AttributesBlock? = nil) {
    fill(path: path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "fill(path:color:attributes:)")
  public static func fillPath(_ path: BezierPath, color: Color, attributes attributesBlock: AttributesBlock? = nil) {
    fill(path: path, color: color, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "fill(rect:color:attributes:)")
  public static func fillRect(_ rect: CGRect, color: Color, attributes attributesBlock: AttributesBlock? = nil) {
    fill(rect: rect, color: color, attributes: attributesBlock)
  }
  
  @available(*, unavailable, renamed: "draw(gradient:startColor:endColor:angleInDegrees:stroke:attributes:)")
  static func drawGradientPath(_ path: BezierPath, startColor: Color, endColor: Color, angleInDegrees: CGFloat, stroke: Bool, attributes attributesBlock: AttributesBlock? = nil) {
    draw(gradient: path, startColor: startColor, endColor: endColor, angleInDegrees: angleInDegrees, stroke: stroke, attributes: attributesBlock)
  }
  
}

extension UIBezierPath {
  
  @available(*, unavailable, renamed: "addLine(to:)")
  public func addLineToPoint(point: CGPoint) {
    addLine(to: point)
  }
  
}

extension CGContext {
  
  @available(*, unavailable, renamed: "draw(in:attributes:drawing:)")
  public func draw(inRect rect: CGRect, attributes attributesBlock: AttributesBlock?, drawing drawingBlock: DrawingBlock) {
    draw(in: rect, attributes: attributesBlock, drawing: drawingBlock)
  }
  
}
