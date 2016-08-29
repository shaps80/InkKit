//
//  CGAffineTransform+Extensions.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 29/08/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

extension CGAffineTransform {
  
  public init(shearX x: CGFloat, y: CGFloat) {
    self.init(a: 1, b: y, c: -x, d: 1, tx: 1, ty: 1)
  }
  
  public func shearedBy(x: CGFloat, y: CGFloat) -> CGAffineTransform {
    var transform = self
    transform.c = -x
    transform.b = y
    return transform
  }
  
}

extension CATransform3D {
  
  public init(perspective distance: CGFloat) {
    self.init(m11: 1, m12: 0, m13: 0, m14: 0, m21: 0, m22: 1, m23: 0, m24: 0, m31: 0, m32: 0, m33: 1, m34: -1/distance, m41: 0, m42: 0, m43: 0, m44: 1)
  }
  
  public func withPerspective(distance: CGFloat) -> CATransform3D {
    var transform = self
    transform.m34 = -1 / distance
    return transform
  }
  
}

