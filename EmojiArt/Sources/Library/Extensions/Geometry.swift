//
//  CGPoint.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 25.08.20.
//

import SwiftUI


extension GeometryProxy {
    func convert(_ point: CGPoint, from coordinateSpace: CoordinateSpace) -> CGPoint {
        let frame = self.frame(in: coordinateSpace)
        return CGPoint(x: point.x-frame.origin.x, y: point.y-frame.origin.y)
    }
}


extension CGPoint {
    static func -(lhs: Self, rhs: Self) -> CGSize { CGSize(width: lhs.x - rhs.x, height: lhs.y - rhs.y) }
    static func -(lhs: Self, rhs: CGSize) -> CGPoint { CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height) }
    static func +(lhs: Self, rhs: CGSize) -> CGPoint { CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height) }
    static func *(lhs: Self, rhs: CGFloat) -> CGPoint { CGPoint(x: lhs.x * rhs, y: lhs.y * rhs) }
    static func /(lhs: Self, rhs: CGFloat) -> CGPoint { CGPoint(x: lhs.x / rhs, y: lhs.y / rhs) }
}


extension CGSize {
    static func -(lhs: Self, rhs: Self) -> CGSize { CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height) }
    static func +(lhs: Self, rhs: Self) -> CGSize { CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height) }
    static func *(lhs: Self, rhs: CGFloat) -> CGSize { CGSize(width: lhs.width * rhs, height: lhs.height * rhs) }
    static func /(lhs: Self, rhs: CGFloat) -> CGSize { CGSize(width: lhs.width / rhs, height: lhs.height / rhs) }
}
