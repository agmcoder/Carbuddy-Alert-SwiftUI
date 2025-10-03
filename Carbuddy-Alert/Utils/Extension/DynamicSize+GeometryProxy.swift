//
//  DynamicSize+GeometryProxy.swift
//  CarBuddy_Alert
//
//  Created by agmcoder on 9/26/25.
//

import SwiftUI

extension GeometryProxy {
    // Dynamic Height Calculator
    func dh(height: Double) -> Double {
        return size.height * height
    }

    // Dynamic Width Calculator
    func dw(width: Double) -> Double {
        return size.width * width
    }
}

// MARK: - USAGE EXAMPLE

//GeometryReader { geometry in
//    // 30% of screen height
//    Rectangle()
//        .frame(height: geometry.dh(height: 0.3))
//
//    // 50% of screen width
//    Rectangle()
//        .frame(width: geometry.dw(width: 0.5))
//
//    // Both width and height
//    Rectangle()
//        .frame(
//            width: geometry.dw(width: 0.8),
//            height: geometry.dh(height: 0.2)
//        )
//}
