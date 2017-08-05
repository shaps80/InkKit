//
//  RendererTypes.swift
//  GraphicsRenderer
//
//  Created by Shaps Benkau on 02/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#if os(OSX)
    import AppKit
    public typealias Image = NSImage

    public func screenScale() -> CGFloat {
        return NSScreen.main!.backingScaleFactor
    }
    
    extension NSImage {
        internal func pngRepresentation() -> Data? {
            return NSBitmapImageRep(data: tiffRepresentation!)?.representation(using: .png, properties: [:])
        }
        
        internal func jpgRepresentation(quality: CGFloat) -> Data? {
            return NSBitmapImageRep(data: tiffRepresentation!)?.representation(using: .jpeg, properties: [NSBitmapImageRep.PropertyKey.compressionFactor: quality])
        }
    }
#else
    import UIKit
    public typealias Image = UIImage
    
    public func screenScale() -> CGFloat {
        return UIScreen.main.scale
    }
    
    extension UIImage {
        internal func pngRepresentation() -> Data? {
            return UIImagePNGRepresentation(self)
        }
        
        internal func jpgRepresentation(quality: CGFloat) -> Data? {
            return UIImageJPEGRepresentation(self, quality)
        }
    }
#endif

extension CGContext {
    
    internal static var current: CGContext? {
        #if os(OSX)
            return NSGraphicsContext.current!.cgContext
        #else
            return UIGraphicsGetCurrentContext()
        #endif
    }
    
}
