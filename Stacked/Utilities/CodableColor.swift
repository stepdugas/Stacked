//
//  CodableColor.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

// A Codable wrapper for SwiftUI Color using RGB
struct CodableColor: Codable, Equatable {
    let red: Double
    let green: Double
    let blue: Double

    init(color: Color) {
        let uiColor = UIColor(color)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
    }

    var color: Color {
        Color(red: red, green: green, blue: blue)
    }
}
