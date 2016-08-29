//
//  BezierPath+Corners.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 29/08/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

public enum RectCornerStyle {
  case none
  case convex(radius: CGFloat)
  case concave(radius: CGFloat)
  case line(radius: CGFloat)
}

public struct RectCorners {
  public var topLeft: RectCornerStyle
  public var topRight: RectCornerStyle
  public var bottomRight: RectCornerStyle
  public var bottomLeft: RectCornerStyle
}

extension RectCorners {
  
  public init(allCorners all: RectCornerStyle) {
    topLeft = all
    topRight = all
    bottomLeft = all
    bottomRight = all
  }
  
  public init(topCorners top: RectCornerStyle) {
    topLeft = top
    topRight = top
    bottomLeft = .none
    bottomRight = .none
  }
  
  public init(bottomCorners bottom: RectCornerStyle) {
    topLeft = .none
    topRight = .none
    bottomLeft = bottom
    bottomRight = bottom
  }
  
  public init(leftCorners left: RectCornerStyle) {
    topLeft = left
    bottomLeft = left
    topRight = .none
    bottomRight = .none
  }
  
  public init(rightCorners right: RectCornerStyle) {
    topLeft = .none
    bottomLeft = .none
    topRight = right
    bottomRight = right
  }
  
}

extension BezierPath {
  
  public convenience init(rect: CGRect, corners: RectCorners) {
    self.init()
    addTopLeftCorner(rect: rect, style: corners.topLeft)
    addTopRightCorner(rect: rect, style: corners.topRight)
    addBottomRightCorner(rect: rect, style: corners.bottomRight)
    addBottomLeftCorner(rect: rect, style: corners.bottomLeft)
    close()
  }
  
  fileprivate func radiusForCornerStyle(style: RectCornerStyle) -> CGFloat {
    switch style {
    case .concave(let radius): return radius
    case .convex(let radius): return radius
    case .line(let radius): return radius
    case .none: return 0
    }
  }
  
  fileprivate func addTopLeftCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.minX, y: rect.minY + radius)
    move(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: CGFloat(M_PI), endAngle: -CGFloat(M_PI_2), clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.minX, y: rect.minY), radius: radius, startAngle: CGFloat(M_PI_2), endAngle: 0, clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.minX + radius, y: rect.minY))
    case .none:
      addLine(to: CGPoint(x: rect.minX, y: rect.minY))
    }
  }
  
  fileprivate func addTopRightCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.maxX - radius, y: rect.minY)
    addLine(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: -CGFloat(M_PI_2), endAngle: 0, clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX, y: rect.minY), radius: radius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2), clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.maxX, y: rect.minY + radius))
    case .none:
      addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    }
  }
  
  fileprivate func addBottomRightCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.maxX, y: rect.maxY - radius)
    addLine(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.maxX, y: rect.maxY), radius: radius, startAngle: CGFloat(M_PI_2) * 3, endAngle: CGFloat(M_PI), clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.maxX - radius, y: rect.maxY))
    case .none:
      addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }
  }
  
  fileprivate func addBottomLeftCorner(rect: CGRect, style: RectCornerStyle) {
    let radius = radiusForCornerStyle(style: style)
    let point1 = CGPoint(x: rect.minX + radius, y: rect.maxY)
    addLine(to: point1)
    
    switch style {
    case .convex(let radius):
      addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true)
    case .concave(let radius):
      addArc(withCenter: CGPoint(x: rect.minX, y: rect.maxY), radius: radius, startAngle: 0, endAngle: -CGFloat(M_PI_2), clockwise: false)
    case .line(let radius):
      addLine(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
    case .none:
      addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    }
  }
  
}

