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

import CoreGraphics

/**
 Represents a series of RGB values
 */
public struct RGBValues {
  /// The red component
  public let red: CGFloat
  
  /// The blue component
  public let blue: CGFloat
  
  /// The green component
  public let green: CGFloat
  
  /// The alpha component
  public let alpha: CGFloat
}

/*
 Represents a series of HSB values
 */
public struct HSBValues {
  /// The hue component
  public let hue: CGFloat
  
  /// The saturation component
  public let saturation: CGFloat
  
  /// The brightness component
  public let brightness: CGFloat
  
  /// The alpha component
  public let alpha: CGFloat
}

extension Color {
  
  /// Returns the RGB values for this color
  public var RGB: RGBValues {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return RGBValues(red: r, blue: b, green: g, alpha: a)
  }
  
  /// Returns the HSB values for this color
  public var HSB: HSBValues {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return HSBValues(hue: h, saturation: s, brightness: b, alpha: a)
  }
  
  /**
   Initializes a new color with the specified HEX value
   
   - parameter hex:   The HEX value representing this color
   - parameter alpha: The alpha value representing this color (defaults to 1)
   
   - returns: A new color
   */
  public convenience init(hex: String, alpha: CGFloat = 1) {
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    let a, r, g, b: UInt32
    
    switch hex.characters.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      fatalError("Unable to parse the hex value")
    }
    
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
  
  /**
   Returns a HEX representation of this color
   
   - parameter alpha: If true, includes the alpha value for this color
   
   - returns: A HEX representation of this color
   */
  public func hexValue(includeAlpha alpha: Bool) -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    if (alpha) {
      return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    } else {
      return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
  }
  
  /**
   Returns a delta of the specified color
   
   - parameter delta: The delta to apply to all color components
   
   - returns: A new color
   */
  public func color(withDelta delta: CGFloat = 0.1) -> Color {
    let d = max(min(delta, 1), -1)
    let values = HSB
    
    return Color(hue: values.hue + d,
                 saturation: values.saturation + d,
                 brightness: values.brightness + d,
                 alpha: values.alpha)
  }
  
  private var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    let rgb = RGB
    return (rgb.red, rgb.green, rgb.blue, rgb.alpha)
  }
  
}
