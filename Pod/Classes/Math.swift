//
//  Math.swift
//  InkKit
//
//  Created by Shaps Mohsenin on 29/08/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import CoreGraphics

public func radians(from degrees: Double) -> CGFloat {
  return CGFloat(degrees * M_PI / 180)
}

public func degrees(from radians: Double) -> CGFloat {
  return CGFloat(radians * 180 / M_PI)
}

