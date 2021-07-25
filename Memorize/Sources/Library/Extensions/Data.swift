//
//  Data.swift
//  Memorize
//
//  Created by Sergey Leschev on 10.10.20.
//

import Foundation


extension Data {
    var utf8: String? { String(data: self, encoding: .utf8)}
}
