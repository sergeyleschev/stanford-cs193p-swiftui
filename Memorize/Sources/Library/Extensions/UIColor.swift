//
//  UIColor.swift
//  Memorize
//
//  Created by Sergey Leschev on 10.10.20.
//

import Foundation
import UIKit
import SwiftUI


extension UIColor {

    public var rgb: RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return RGB(red: red, green: green, blue: blue, alpha: alpha)
    }

    
    convenience init(_ rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }
    
    
    static func getRGB(_ uiColor: UIColor) -> RGB {
        RGB(red: uiColor.rgb.red, green: uiColor.rgb.green, blue: uiColor.rgb.blue, alpha: uiColor.rgb.alpha)
    }
    
    
}


extension Color {
    init(_ rgb: RGB) { self.init(UIColor(rgb)) }
}

