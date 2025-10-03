//
//  PagePaddings.swift
//  CarBuddy_Alert
//
//  Created by agmcoder on 9/24/25.
//

import SwiftUI

struct PagePaddings {
    /// Global padding values to apply on all edges.
    enum All: CGFloat {
        case lowest = 4
        case low = 8
        case mediumLow = 10
        case medium = 12
        case normal = 15
        case high = 20
    }

    /// Horizontal-only padding values (leading/trailing).
    enum Horizontal: CGFloat {
        case lowest = 5
        case low = 10
        case normal = 20
        case high = 30
    }

    /// Vertical-only padding values (top/bottom).
    enum Vertical: CGFloat {
        case lowest = 5
        case low = 10
        case normal = 20
        case high = 30
    }

    /// Spacing used between components.
    enum Component: CGFloat {
        case low = 2
    }
}
 
extension PagePaddings {
    static func all(_ padding: All) -> CGFloat { padding.rawValue }
    static func horizontal(_ padding: Horizontal) -> CGFloat { padding.rawValue }
    static func vertical(_ padding: Vertical) -> CGFloat { padding.rawValue }
    static func component(_ spacing: Component) -> CGFloat { spacing.rawValue }

//    /// Convenience helper to create EdgeInsets from horizontal and vertical values.
//    static func insets(horizontal: Horizontal = .normal, vertical: Vertical = .normal) -> EdgeInsets {
//        EdgeInsets(top: vertical.rawValue, leading: horizontal.rawValue, bottom: vertical.rawValue, trailing: horizontal.rawValue)
//    }
}

//extension View {
//    /// Applies page padding to all edges using PagePaddings.All.
//    func pagePadding(_ all: PagePaddings.All) -> some View {
//        padding(all.rawValue)
//    }
//
//    /// Applies horizontal page padding using PagePaddings.Horizontal.
//    func pagePadding(horizontal: PagePaddings.Horizontal) -> some View {
//        padding(.horizontal, horizontal.rawValue)
//    }
//
//    /// Applies vertical page padding using PagePaddings.Vertical.
//    func pagePadding(vertical: PagePaddings.Vertical) -> some View {
//        padding(.vertical, vertical.rawValue)
//    }
//}
