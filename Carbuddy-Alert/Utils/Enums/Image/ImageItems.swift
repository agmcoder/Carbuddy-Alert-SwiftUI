//
//  ImageItems.swift
//  CarBuddy_Alert
//
//  Created by agmcoder on 9/24/25.
//

import SwiftUI

// MARK: - ImageItems
/// System for organizing app images
struct ImageItems {
    
    /// Images used in application onboarding screens
    enum Onboard: String {
        case onboard1 = "img_onboard1"
        case onboard2 = "img_onboard2"
        case onboard3 = "img_onboard3"
    }
    
    /// General application images
    enum App: String {
        case noTask = "img_no_task"
        case uptodo = "img_uptodo"
    }
}

// MARK: - IconItems
/// System for organizing app icons
struct IconItems {
    
    /// Basic app icons used throughout the application
    enum App: String {
        case flag = "ic_flag"
    }
    
    /// Category-based icons
    enum Category: String {
        case create_new = "img_category_create_new"
        case design = "img_category_design"
        case grocery = "img_category_grocery"
        case health = "img_category_health"
    }
}

// MARK: - String Extension
extension String {
    /// String path to image
    /// - Returns: related image from image asset
    func image() -> Image {
        return Image(self)
    }
    
    /// Helper function for resizable Image
    /// - Returns: Resizable Image
    func resizableImage() -> Image {
        return Image(self).resizable()
    }
    
    /// Helper function for Image with rendering mode
    /// - Parameter template: Whether to use template rendering mode
    /// - Returns: Configured Image
    func image(template: Bool = false) -> Image {
        let image = Image(self)
        return template ? image.renderingMode(.template) : image
    }
}
