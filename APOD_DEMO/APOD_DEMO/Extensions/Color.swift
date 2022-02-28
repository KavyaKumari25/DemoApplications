//
//  Color.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
}
