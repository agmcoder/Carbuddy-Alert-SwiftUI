//
//  AppSize.swift
//  CarBuddy_Alert
//
//  Created by agmcoder on 9/24/25.
//
import Foundation
import CoreGraphics
import SwiftUI

/// Unified size system with consistent naming and minimal dependencies
struct AppSize {
    
    // MARK: - Text Line Limits
    static let titleTextLineLimit = 1
    static let descriptionTextLineLimit = 3
    static let bodyTextLineLimit = 2
    
    // MARK: - Line Widths
    enum LineWidth: CGFloat {
        case thin = 0.5
        case textField = 0.8
        case regular = 1.0
        case bold = 2.0
        case thick = 3.0
    }
    
    // MARK: - Heights
    enum Height: CGFloat {
        case lowest
        case low
        case normal
        case medium
        case high
        case maxHeight
        case statusBar
        case button
        case textField
        case signInLogo
        
        var value: CGFloat {
            switch self {
            case .lowest: return 12
            case .low: return 35
            case .normal: return 40
            case .medium: return 60
            case .high: return 80
            case .maxHeight: return .infinity
            case .statusBar: return 20
            case .button: return 44
            case .textField: return 48
            case .signInLogo: return 150
            }
        }
    }
    
    // MARK: - Widths
    enum Width {
        case lowest
        case low
        case normal
        case medium
        case high
        case maxWidth
        case statusBar
        case button
        case textField
        case signInLogo
        
        var value: CGFloat {
            switch self {
            case .lowest: return 20
            case .low: return 35
            case .normal: return 50
            case .medium: return 100
            case .high: return 150
            case .maxWidth: return .infinity
            case .statusBar: return 20
            case .button: return 44
            case .textField: return 200
            case .signInLogo: return 150
            }
        }
    }
    
    // MARK: - View Sizes
    enum ViewSize: CGFloat {
        case lowest = 12
        case low = 20
        case normal = 40
        case medium = 60
        case high = 80
        case highest = 100
    }
    
    
    // MARK: - Spacing System
    enum Spacing: CGFloat {
        case lowest = 4
        case low = 8
        case mediumLow = 10
        case medium = 12
        case normal = 15
        case high = 20
        case highest = 30
        case extraHigh = 40
    }
    
    // MARK: - Opacities
    enum Opacity: CGFloat {
        case lowest = 0.05
        case low = 0.1
        case medium = 0.15
        case normal = 0.25
        case high = 0.5
        case highest = 0.8
    }
    
    // MARK: - Corner Radius
    enum CornerRadius: CGFloat {
        case lowest = 4.0
        case low = 8.0
        case medium = 10.0
        case normal = 15.0
        case high = 30.0
    }
    
    // MARK: - Shadow Radius
    enum ShadowRadius: CGFloat {
        case small = 2
        case medium = 4
        case large = 8
        case xLarge = 12
    }
    
    // MARK: - Icon Sizes
    enum IconSize: CGFloat {
        case small = 16
        case medium = 24
        case large = 32
        case xLarge = 40
    }
    
    enum ButtonSize: CGFloat {
        case small = 44
        case medium = 56
        case large = 68
    }
}

// MARK: - Semantic Aliases
extension AppSize.Height {
    /// Use for tab bar height
    static var tabBar: AppSize.Height { .high }
    /// Use for navigation bar height
    static var navigationBar: AppSize.Height { .button }
}

// MARK: - Convenience Static Methods
extension AppSize {
    static func lineWidth(_ value: LineWidth) -> CGFloat { value.rawValue }
    static func viewSize(_ value: ViewSize) -> CGFloat { value.rawValue }
    static func height(_ value: Height) -> CGFloat { value.rawValue }
    static func width(_ value: Width) -> CGFloat { value.value }
    static func spacing(_ value: Spacing) -> CGFloat { value.rawValue }
    static func opacity(_ value: Opacity) -> CGFloat { value.rawValue }
    static func cornerRadius(_ value: CornerRadius) -> CGFloat { value.rawValue }
    static func shadowRadius(_ value: ShadowRadius) -> CGFloat { value.rawValue }
    static func iconSize(_ value: IconSize) -> CGFloat { value.rawValue }
}

// MARK: - Default Values
extension AppSize {
    static var defaultButtonHeight: CGFloat { Height.button.rawValue }
    static var defaultCornerRadius: CGFloat { CornerRadius.medium.rawValue }
    static var defaultPadding: CGFloat { Spacing.medium.rawValue }
    static var defaultShadowOpacity: CGFloat { Opacity.normal.rawValue }
    static var defaultIconSize: CGFloat { IconSize.medium.rawValue }
}

// MARK: - EdgeInsets, padding for views
extension EdgeInsets{
    public static let paddingAllLow = EdgeInsets.init(top: 12, leading: 12, bottom: 12, trailing: 12)
    public static let paddingAllNormal = EdgeInsets.init(top: 16, leading: 16, bottom: 16, trailing: 16)
    public static let paddingAllHigh = EdgeInsets.init(top: 20, leading: 20, bottom: 20, trailing: 20)
}

// Usage examples
/*
 // Using low padding
 Rectangle()
 .padding(EdgeInsets.paddingAllLow)
 
 // Using normal padding
 VStack {
 Text("Header")
 }
 .padding(EdgeInsets.paddingAllNormal)
 
 // Using high padding
 Card()
 .padding(EdgeInsets.paddingAllHigh)
 */

// MARK: - Typography Sizes (fallback)

struct Typography {
    enum Size {
        static let largeTitle: CGFloat = 34
        static let title1: CGFloat = 28
        static let title2: CGFloat = 22
        static let title3: CGFloat = 20
        static let headline: CGFloat = 17
        static let body: CGFloat = 17
        static let callout: CGFloat = 16
        static let subheadline: CGFloat = 15
        static let footnote: CGFloat = 13
        static let caption1: CGFloat = 12
        static let caption2: CGFloat = 11
    }
    enum LineHeight: CGFloat {
        case tight = 1.2
        case normal = 1.5
        case loose = 1.8
    }
}

// MARK: - Fonts
extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return Typography.Size.largeTitle
        case .title: return Typography.Size.title1
        case .title2: return Typography.Size.title2
        case .title3: return Typography.Size.title3
        case .headline: return Typography.Size.headline
        case .body: return Typography.Size.body
        case .callout: return Typography.Size.callout
        case .subheadline: return Typography.Size.subheadline
        case .footnote: return Typography.Size.footnote
        case .caption: return Typography.Size.caption1
        case .caption2: return Typography.Size.caption2
        @unknown default:
            return Typography.Size.body
        }
    }
}

// Usage example
//Text("Header")
//    .font(.system(size: Font.TextStyle.title.size))
//
//Text("Content")
//    .font(.system(size: Font.TextStyle.body.size))
//
//Text("Subtitle")
//    .font(.system(size: Font.TextStyle.subheadline.size))
