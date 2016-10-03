//
//  Renderer-Drawing.swift
//  GraphicsRenderer
//
//  Created by Shaps Benkau on 02/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

extension RendererDrawable {
    
    /// Fills the specified rect
    ///
    /// - Parameter rect: The rect to fill
    public func fill(_ rect: CGRect) {
        fill(rect, blendMode: .normal)
    }
    
    /// Fills the specified rect with the given blend mode
    ///
    /// - Parameters:
    ///   - rect: The rect to fill
    ///   - blendMode: The blend mode to apply to this fill
    public func fill(_ rect: CGRect, blendMode: CGBlendMode) {
        cgContext.saveGState()
        cgContext.setBlendMode(blendMode)
        cgContext.fill(rect)
        cgContext.restoreGState()
    }
    
    /// Strokes the specified rect
    ///
    /// - Parameter rect: The rect to stroke
    public func stroke(_ rect: CGRect) {
        stroke(rect, blendMode: .normal)
    }
    
    /// Strokes the specified rect with the given blend mode
    ///
    /// - Parameters:
    ///   - rect: The rect to stroke
    ///   - blendMode: The blend more to apply to this stroke
    public func stroke(_ rect: CGRect, blendMode: CGBlendMode) {
        cgContext.saveGState()
        cgContext.setBlendMode(blendMode)
        cgContext.stroke(rect.insetBy(dx: 0.5, dy: 0.5))
        cgContext.restoreGState()
    }
    
    /// Clips the context to the specified rect
    ///
    /// - Parameter rect: The rect to clip to
    public func clip(to rect: CGRect) {
        cgContext.saveGState()
        cgContext.clip(to: rect)
        cgContext.restoreGState()
    }
}
