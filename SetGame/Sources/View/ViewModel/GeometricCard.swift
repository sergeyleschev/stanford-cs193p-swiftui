//
//  GeometricCard.swift
//  SetGame
//
//  Created by Sergey Leschev on 08.10.20.
//

import Foundation


struct GeometricCard: SetCard, CustomStringConvertible, Identifiable, Hashable {
    typealias FeatureA = Number
    typealias FeatureB = Coloring
    typealias FeatureC = Shading
    typealias FeatureD = Figure

    enum Number: Int, CaseIterable, SetCategory {
        typealias Content = Self
        case one = 1, two, three
    }
    
    enum Coloring: CaseIterable, SetCategory {
        typealias Content = Self
        case red, green, blue
    }

    enum Shading: CaseIterable, SetCategory {
        typealias Content = Self
        case solid, striped, open
    }
    
    enum Figure: CaseIterable, SetCategory {
        typealias Content = Self
        case star, circle, diamond
    }
    
    var featureA: Number { number }
    var featureB: Coloring { color }
    var featureC: Shading { shading }
    var featureD: Figure { figure }

    var number: Number
    var color: Coloring
    var shading: Shading
    var figure: Figure

    var id = UUID()
    var isFaceUp = false
    var isSelected = false
    var isMatched = false

    
    var description: String {
        let facedUp = isFaceUp ? "🃏 faced up" : "faced down"
        let selected = isSelected ? "✅ selected" : "unselected"
        let ending = number.rawValue > 1 ? "s" : ""
        return "Card with \(number.rawValue) \(color) \(figure)\(ending) with \(shading) shading - \(facedUp) and \(selected)"
    }

    
    static func generateAll() -> [Self] {
        var cards = [Self]()
        for number in Number.allCases {
            for color in Coloring.allCases {
                for shading in Shading.allCases {
                    for figure in Figure.allCases {
                        cards.append(Self.init(number: number, color: color, shading: shading, figure: figure))
                    }
                }
            }
        }
        return cards
    }

}

