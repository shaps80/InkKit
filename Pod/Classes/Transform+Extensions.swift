//
//  Transform+Extensions.swift
//  InkKitOSXDemo
//
//  Created by Shaps Mohsenin on 12/05/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

#if os(OSX)
  
import AppKit

extension NSAffineTransform {
  
  public static func fromCGAffineTransform(transform: CGAffineTransform) -> NSAffineTransform {
    let t = NSAffineTransform()
    
    t.transformStruct.m11 = transform.a
    t.transformStruct.m12 = transform.b
    t.transformStruct.m21 = transform.c
    t.transformStruct.m22 = transform.d
    t.transformStruct.tX = transform.tx
    t.transformStruct.tY = transform.ty
    
    return t
  }
  
}

#endif
