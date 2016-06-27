# InkKit

[![Version](https://img.shields.io/cocoapods/v/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)
[![License](https://img.shields.io/cocoapods/l/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)
[![Language](https://img.shields.io/badge/language-swift-ff69b4.svg)](http://cocoadocs.org/docsets/InkKit)
[![Platform](https://img.shields.io/cocoapods/p/InkKit.svg?style=flat)](http://cocoapods.org/pods/InkKit)

#### Note
> In order to use the Swift 3.0 version add the following to your Podfile
> 
> `pod 'InkKit', :git => 'https://github.com/shaps80/InkKit.git', :branch => 'Swift3.0'`

--- 

Everything you see here, was code-drawn with InkKit! In fact, other than some `CGRect` instances, this is ALL the code required to draw the image you see on the right ;)

<table>
  <tr>
    <th width="30%">Drawing made simple!</th>
    <th width="30%">InkKit In Action</th>
  </tr>
  <tr>
    <td>Lets draw the screen on the right.</td>
    <th rowspan="9"><img src="http://shaps.me/assets/img/blog/InkKit.gif"></th>
  </tr>
  <tr><td><div class="highlight highlight-source-swift"><pre>
Draw.fill(rect: bgFrame, color: UIColor(hex: "1c3d64"))
let grid = Grid(colCount: 6, rowCount: 9, bounds: gridFrame)
let path = grid.path(include: [.columns, .rows])

Draw.stroke(path: path, startColor: UIColor(white: 1, alpha: 0.15),
    endColor: UIColor(white: 1, alpha: 0.05), angleInDegrees: 90)

let rect = grid.boundsForRange(sourceColumn: 1, sourceRow: 1,
                      destinationColumn: 4, destinationRow: 6)

drawCell(in: rect, title: "4x6",
  includeBorder: true, includeShadow: true)

Draw.add(shadow: .Outer, path: UIBezierPath(rect: barFrame),
           color: UIColor(white: 0, alpha: 0.4), radius: 5,
                       offset: CGSize(width: 0, height: 1))

Draw.fill(rect: barFrame, color: UIColor(hex: "ff0083"))

let (_, navFrame) = barFrame.divide(20, fromEdge: .MinYEdge)
"InkKit".draw(alignedTo: navFrame, attributes: [
  NSForegroundColorAttributeName: Color.whiteColor(),
  NSFontAttributeName: UIFont(name: "Avenir-Book", size: 20)!
])

backIndicatorImage()
  .with(tint: .white())
  .draw(at: CGPoint(x: 22, y: 30))  
</pre></div></td></tr>
</table>

## Change Log

**v2.0.0**

* Swift 3.0 Support
* Updated API to support Swift 3.0 guidelines
* Image.with(tint:blendMode:) -- Tinting images made easy!

**v1.3.1**

* OSX Support
* OSX Demo Project now included
* ~~Table~~ renamed to Grid
* ~~Table~~ renamed to GridComponents
* Added convenience methods for working with paths

**v1.2.0**

* Shadows
* Borders
* Tables

**v1.1.0**

* Images
* Strings

**v1.0**

* Fills
* Strokes
* Geometry

## API

InkKit provides many useful convenience methods for drawing and geometry calculations.

### Core

If the convenience methods below don't solve your needs, you can start by using the new methods added directly to `CGContext` itself:

```swift
func draw(in:attributes:drawing:)
```

Which would look like this in usage:

```swift
GraphicsContext()?.draw(in: rect, drawing: { (context, rect, attributes) in
  Color.redColor.setFill()
  UIRectFill(rect)
})
```

This basically wraps getting the context, setting up its frame and save/restore calls. If you provide the additional DrawingAttributes block, it will also pre-configure your context with those options for you.

### Grid

```swift
init(colCount:rowCount:bounds:)
func positionForCell(at:) -> (col: Int, row: Int)
func boundsForCell(at:) -> CGRect
func boundsForRange(sourceColumn:sourceRow:destinationColumn:destinationRow:) -> CGRect
func boundsForCell(col:row:) -> CGRect
func enumerateCells(_ enumerator:(index:col:row:bounds:) -> Void)
```

A `Grid` is a really great way for laying out your drawing without having to think about placement, rect translations, etc...

I use them often for layout only, but sometimes its useful to be able to render them as well (like in the included demo).

```swift
// components is a bitmask [ .outline, .rows, .columns ]
func stroke(components:attributes:)
```

### Borders & Shadows

Supports `.outer`, `.inner` and `.center` borders, as well as `.outer` and `.inner` shadows.

```swift
static func add(border:path:attributes:)
static func add(shadow:path:color:radius:offset:)
```

### Strokes

```swift
static func strokeLine(from:to:startColor:endColor:angleInDegrees:attributes:)
static func strokeLine(from:to:color:attributes:)
static func stroke(path:startColor:endColor:angleInDegrees:attributes:)
```


### Fills

```swift
static func fill(path:startColor:endColor:angleInDegrees:attributes:)
```

### Geometry

Many of the drawing methods use the geometry additions below, but they can also be useful for your own projects:

```swift
func divide(at:fromEdge:margin:) -> (slice, remainder)
func inset(by:) -> CGRect 			
mutating func insetInPlace(by:)		
func aligned(to:horizontal:vertical:) -> CGRect
func scaled(to:rect:scaleMode:) -> CGRect

func gradientPoints(forAngleInDegrees:) -> (start, end)
func scaled(to:scaleMode:) -> CGSize

func reversibleRect(from:to:) -> CGRect
```

### Images

There are also additional draw methods for images:

```swift
func draw(alignedTo:horizontal:vertical:blendMode:alpha:)
func draw(scaledTo:scaleMode:blendMode:alpha:)

static func circle(radius:attributes:) -> Image
static func draw(width:height:scale:attributes:drawing:) -> Image
static func draw(size:scale:attributes:drawing:) -> Image
```

### Strings

Finally, we even have some easy draw methods for strings:

```swift
func draw(alignedTo:horizontal:vertical:constrainedSize:attributes:)
func sizeWith(attributes:constrainedSize:) -> CGSize
func draw(at:attributes:)
func draw(in:attributes)
```

## Demo

To try it out yourself, download the [source](http://github.com/shaps80/InkKit) and run the included demo projects. There is also an OSX Demo project!

## Platforms and Versions

InkKit is supported on the following platforms:

* iOS 8.0 and greater
* OSX 10.11 and greater

## Installation

InkKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InkKit'
```

Alternatively you can simply drag the files into your iOS or OSX project.


## Author

[@shaps](http://twitter.com/shaps)

## License

InkKit is available under the MIT license. See the LICENSE file for more info.
