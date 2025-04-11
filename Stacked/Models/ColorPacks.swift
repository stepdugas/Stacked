//
//  ColorPacks.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/11/25.
//

import SwiftUI

struct ColorPack: Identifiable {
    let id = UUID()
    let name: String
    let colors: [Color]
}

let colorPacks: [ColorPack] = [
    ColorPack(name: "Pastel", colors: [
        Color(red: 1.0, green: 0.8, blue: 0.9),
        Color(red: 1.0, green: 1.0, blue: 0.8),
        Color(red: 0.8, green: 1.0, blue: 0.8),
        Color(red: 0.8, green: 0.9, blue: 1.0),
        Color(red: 1.0, green: 0.9, blue: 0.8)
    ]),
    ColorPack(name: "Neon", colors: [
        Color(hex: "#FF6EC7"),
        Color(hex: "#00FFFF"),
        Color(hex: "#39FF14"),
        Color(hex: "#FFFF33"),
        Color(hex: "#FFAA33")
    ]),
    ColorPack(name: "Ocean", colors: [
        Color(hex: "#008080"),
        Color(hex: "#66FFCC"),
        Color(hex: "#FF7F50"),
        Color(hex: "#87CEFA"),
        Color(hex: "#FAF3E0")
    ]),
    ColorPack(name: "Monochrome", colors: [
        Color(hex: "#708090"),
        Color(hex: "#36454F"),
        Color(hex: "#F5F5F5"),
        Color(hex: "#121212")
    ]),
    ColorPack(name: "Candy", colors: [
        Color(hex: "#FFB6C1"),
        Color(hex: "#FFFACD"),
        Color(hex: "#DA70D6"),
        Color(hex: "#B0E0E6")
    ])
]
