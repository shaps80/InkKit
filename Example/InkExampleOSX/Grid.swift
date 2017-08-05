//
//  Grid.swift
//  InkKit
//
//  Created by Shahpour Benkau on 11/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreGraphics

public struct LayoutMargins {
    public let start: CGFloat
    public let end: CGFloat
    
    public init(start: CGFloat, end: CGFloat) {
        self.start = start
        self.end = end
    }
    
    public static func both(_ margin: CGFloat) -> LayoutMargins {
        return LayoutMargins(start: margin, end: margin)
    }
}

extension LayoutMargins: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(start: CGFloat(value), end: CGFloat(value))
    }
}

extension LayoutMargins: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(start: CGFloat(value), end: CGFloat(value))
    }
}

public protocol Cell {
    var offset: Int { get }
    var span: Int { get }
    var size: CGFloat { get }
}

public struct GridCell: Cell {
    public let offset: Int
    public let span: Int
    
    // height for column, width for row
    public let size: CGFloat
    
    public init(offset: Int = 0, span: Int = 0, size: CGFloat) {
        self.offset = offset
        self.span = span
        self.size = size
    }
}

public struct Grid: Cell {
    public enum Layout {
        case columns(Int)
        case rows(Int)
    }
    
    fileprivate var count: Int {
        switch layout {
        case .columns(let count): return count
        case .rows(let count): return count
        }
    }
    
    public var layout: Layout
    public var margins: LayoutMargins
    public var gutter: CGFloat
    public var cells = [Cell]()
    
    public let offset: Int
    public let span: Int
    
    // height for column, width for row
    public let size: CGFloat
    
    public init(with layout: Layout, gutter: CGFloat = 16, margins: LayoutMargins = .both(0)) {
        self.layout = layout
        self.gutter = gutter
        self.margins = margins
        
        self.offset = 0
        self.span = 0
        self.size = 0
    }
}

extension Grid {
    public var flattened: [Cell] {
        let grids = cells.flatMap { $0 as? Grid }
        return [self] + grids.flatMap { $0.flattened }
    }
}

struct GridCellAttributes {
    let frame: CGRect
    let cell: Cell
}

//extension Cell {
//    private func frame(for cell: Cell, in frame: CGRect, withColumns count: Int) -> CGRect {
//        let availableWidth = width - (start + end) - (gutter * CGFloat(count - 1))
//        let singleCellWidth = availableWidth / CGFloat(count)
//        
//        let cell = cells[index]
//        var x = bounds.origin.x + margins.start
//        x += CGFloat(cell.offset) * gutter
//        x += CGFloat(cell.offset) * singleCellWidth
//        
//        var width = CGFloat(cell.span) * singleCellWidth
//        width += CGFloat(cell.span - 1) * gutter
//        
//        return CGRect(x: x, y: 0, width: width, height: cell.size)
//    }
//}
//
//extension Grid {
//    
//    public func layout(in frame: CGRect) -> CGRect {
//        let count: Int
//        
//        switch layout {
//        case .columns(let c): count = c
//        case .rows(let c): count = c
//        }
//        
//        let availableSpace = frame.width - (margins.start + margins.end) - (gutter * CGFloat(count - 1))
//        let singleCellWidth = availableWidth / CGFloat(count)
//    }
//    
//    func boundsForCell(at index: Int) -> CGRect {
//        var rect = frameForCell(at: index)
//        rect.origin = .zero
//        return rect
//    }
//    
//    
//}


