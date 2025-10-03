//
//  ConfigurationProtocol.swift
//  CarBuddy_Alert
//
//  Created by agmcoder on 9/23/25.
//

import Foundation

protocol ConfigurationProtocol {
    var apiBaseURL: String { get }
    var isLoggingEnabled: Bool { get }
    var analyticsKey: String { get }
    var isDebugMenuEnabled: Bool { get }
    var environmentName: String { get }
    
    // Network settings
    var apiTimeout: TimeInterval { get }
    var maxRetryAttempts: Int { get }
    
    // Feature flags
    var isFeatureXEnabled: Bool { get }
    var isBetaFeaturesEnabled: Bool { get }
}

// MARK: - Development Configuration
struct DevelopmentConfiguration: ConfigurationProtocol {
    let apiBaseURL = "https://api-dev.myapp.com"
    let isLoggingEnabled = true
    let analyticsKey = "dev-analytics-key"
    let isDebugMenuEnabled = true
    let environmentName = "Development"
    
    // Network settings - more lenient for dev
    let apiTimeout: TimeInterval = 30.0
    let maxRetryAttempts = 3
    
    // Feature flags - enable experimental features
    let isFeatureXEnabled = true
    let isBetaFeaturesEnabled = true
}

// MARK: - Staging Configuration
struct StagingConfiguration: ConfigurationProtocol {
    let apiBaseURL = "https://api-staging.myapp.com"
    let isLoggingEnabled = true
    let analyticsKey = "staging-analytics-key"
    let isDebugMenuEnabled = false
    let environmentName = "Staging"
    
    // Network settings - production-like
    let apiTimeout: TimeInterval = 15.0
    let maxRetryAttempts = 2
    
    // Feature flags - only stable features
    let isFeatureXEnabled = true
    let isBetaFeaturesEnabled = false
}

// MARK: - Production Configuration
struct ProductionConfiguration: ConfigurationProtocol {
    let apiBaseURL = "https://api.myapp.com"
    let isLoggingEnabled = false
    let analyticsKey = "prod-analytics-key"
    let isDebugMenuEnabled = false
    let environmentName = "Production"
    
    // Network settings - optimized for performance
    let apiTimeout: TimeInterval = 10.0
    let maxRetryAttempts = 1
    
    // Feature flags - only proven features
    let isFeatureXEnabled = true
    let isBetaFeaturesEnabled = false
}

