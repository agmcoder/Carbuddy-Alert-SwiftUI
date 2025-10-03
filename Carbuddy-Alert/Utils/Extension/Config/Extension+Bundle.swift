//
//  Extension+Bundle.swift
//  CarBuddy_Alert
//
//  Created by agmcoder on 9/23/25.
//

import Foundation

extension Bundle {
    var environmentName: String {
        return ConfigurationManager.shared.environment
    }
    
    var isDebugBuild: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    var buildInfo: String {
        let version = infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let build = infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
        return "\(environmentName) v\(version) (\(build))"
    }
}
