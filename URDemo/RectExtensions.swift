//
//  RectExtensions.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import CoreGraphics

extension CGRect {
    // Corners
    public var minXminY: CGPoint { return CGPoint(x: minX, y: minY) }
    public var maxXminY: CGPoint { return CGPoint(x: maxX, y: minY) }
    public var maxXmaxY: CGPoint { return CGPoint(x: maxX, y: maxY) }
    public var minXmaxY: CGPoint { return CGPoint(x: minX, y: maxY) }

    // Sides
    public var midXminY: CGPoint { return CGPoint(x: midX, y: minY) }
    public var midXmaxY: CGPoint { return CGPoint(x: midX, y: maxY) }
    public var maxXmidY: CGPoint { return CGPoint(x: maxX, y: midY) }
    public var minXmidY: CGPoint { return CGPoint(x: minX, y: midY) }

    // Already provided by CGRect:
    //  public var minX
    //  public var midX
    //  public var maxX
    //  public var minY
    //  public var midY
    //  public var maxY

    // Center
    public var midXmidY: CGPoint { return CGPoint(x: midX, y: midY) }

    // Dimensions

    // Already provided by CGRect:
    //  public var width
    //  public var height
}

extension CGRect {
    // Corners
    public func settingMinXminY(_ p: CGPoint) -> CGRect { return CGRect(origin: p, size: size) }
    public func settingMaxXminY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x - size.width, y: p.y), size: size) }
    public func settingMaxXmaxY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x - size.width, y: p.y - size.height), size: size) }
    public func settingMinXmaxY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x, y: p.y - size.height), size: size) }

    // Sides
    public func settingMinX(_ x: CGFloat) -> CGRect { return CGRect(origin: CGPoint(x: x, y: origin.y), size: size) }
    public func settingMaxX(_ x: CGFloat) -> CGRect { return CGRect(origin: CGPoint(x: x - size.width, y: origin.y), size: size) }
    public func settingMidX(_ x: CGFloat) -> CGRect { return CGRect(origin: CGPoint(x: x - size.width / 2, y: origin.y), size: size) }

    public func settingMinY(_ y: CGFloat) -> CGRect { return CGRect(origin: CGPoint(x: origin.x, y: y), size: size) }
    public func settingMaxY(_ y: CGFloat) -> CGRect { return CGRect(origin: CGPoint(x: origin.x, y: y - size.height), size: size) }
    public func settingMidY(_ y: CGFloat) -> CGRect { return CGRect(origin: CGPoint(x: origin.x, y: y - size.height / 2), size: size) }

    public func settingMidXminY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x - size.width / 2, y: p.y), size: size) }
    public func settingMidXmaxY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x - size.width / 2, y: p.y - size.height), size: size) }
    public func settingMaxXmidY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x - size.width, y: p.y - size.height / 2), size: size) }
    public func settingMinXmidY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x, y: p.y - size.height / 2), size: size) }

    // Center
    public func settingMidXmidY(_ p: CGPoint) -> CGRect { return CGRect(origin: CGPoint(x: p.x - size.width / 2, y: p.y - size.height / 2), size: size) }

    // Dimensions
    public func settingWidth(_ w: CGFloat) -> CGRect { return CGRect(origin: origin, size: CGSize(width: w, height: size.height)) }
    public func settingHeight(_ h: CGFloat) -> CGRect { return CGRect(origin: origin, size: CGSize(width: size.width, height: h)) }
}

extension CGRect {
    // These functions can produce rectangles that have a different size.

    // Corners
    public func settingMinXminYIndependent(_ p: CGPoint) -> CGRect { return settingMinXIndependent(p.x).settingMinYIndependent(p.y) }
    public func settingMaxXminYIndependent(_ p: CGPoint) -> CGRect { return settingMaxXIndependent(p.x).settingMinYIndependent(p.y) }
    public func settingMaxXmaxYIndependent(_ p: CGPoint) -> CGRect { return settingMaxXIndependent(p.x).settingMaxYIndependent(p.y) }
    public func settingMinXmaxYIndependent(_ p: CGPoint) -> CGRect { return settingMinXIndependent(p.x).settingMaxYIndependent(p.y) }

    // Sides
    public func settingMinXIndependent(_ x: CGFloat) -> CGRect { let dx = minX - x; return settingMinX(x).settingWidth(width + dx).standardized }
    public func settingMaxXIndependent(_ x: CGFloat) -> CGRect { let dx = maxX - x; return settingMaxX(x).settingWidth(width + dx).standardized }

    public func settingMinYIndependent(_ y: CGFloat) -> CGRect { let dy = minY - y; return settingMinY(y).settingHeight(height + dy).standardized }
    public func settingMaxYIndependent(_ y: CGFloat) -> CGRect { let dy = maxY - y; return settingMaxY(y).settingHeight(height + dy).standardized }
}

extension CGRect {
    // Corners
    public mutating func setMinXminY(_ p: CGPoint) { origin = p }
    public mutating func setMaxXminY(_ p: CGPoint) { origin.x = p.x - size.width; origin.y = p.y }
    public mutating func setMaxXmaxY(_ p: CGPoint) { origin.x = p.x - size.width; origin.y = p.y - size.height }
    public mutating func setMinXmaxY(_ p: CGPoint) { origin.x = p.x; origin.y = p.y - size.height }

    // Sides
    public mutating func setMinX(_ x: CGFloat) { origin.x = x }
    public mutating func setMaxX(_ x: CGFloat) { origin.x = x - size.width }
    public mutating func setMidX(_ x: CGFloat) { origin.x = x - size.width / 2 }

    public mutating func setMinY(_ y: CGFloat) { origin.y = y }
    public mutating func setMaxY(_ y: CGFloat) { origin.y = y - size.height }
    public mutating func setMidY(_ y: CGFloat) { origin.y = y - size.height / 2 }

    public mutating func setMidXminY(_ p: CGPoint) { origin.x = p.x - size.width / 2; origin.y = p.y }
    public mutating func setMidXmaxY(_ p: CGPoint) { origin.x = p.x - size.width / 2; origin.y = p.y - size.height }
    public mutating func setMaxXmidY(_ p: CGPoint) { origin.x = p.x - size.width; origin.y = p.y - size.height / 2 }
    public mutating func setMinXmidY(_ p: CGPoint) { origin.x = p.x; origin.y = p.y - size.height / 2 }

    // Dimensions
    public mutating func setWidth(_ w: CGFloat) { size.width = w }
    public mutating func setHeight(_ h: CGFloat) { size.height = h }
}

extension CGRect {
    // These functions can produce rectangles that have a different size.

    // Corners
    public mutating func setMinXminYIndependent(_ p: CGPoint) { setMinXIndependent(p.x); setMinYIndependent(p.y) }
    public mutating func setMaxXminYIndependent(_ p: CGPoint) { setMaxXIndependent(p.x); setMinYIndependent(p.y) }
    public mutating func setMaxXmaxYIndependent(_ p: CGPoint) { setMaxXIndependent(p.x); setMaxYIndependent(p.y) }
    public mutating func setMinXmaxYIndependent(_ p: CGPoint) { setMinXIndependent(p.x); setMaxYIndependent(p.y) }

    // Sides
    public mutating func setMinXIndependent(_ x: CGFloat) { let dx = minX - x; setMinX(x); size.width += dx; self = standardized }
    public mutating func setMaxXIndependent(_ x: CGFloat) { let dx = maxX - x; /*setMaxX(x);*/ size.width -= dx; self = standardized }

    public mutating func setMinYIndependent(_ y: CGFloat) { let dy = minY - y; setMinY(y); size.height += dy; self = standardized }
    public mutating func setMaxYIndependent(_ y: CGFloat) { let dy = maxY - y; setMaxY(y); size.height += dy; self = standardized }
}
