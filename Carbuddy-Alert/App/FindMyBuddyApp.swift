//
//  Carbuddy_AlertApp.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/3/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FindMyBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Initialize dependencies
private extension AppDelegate {
    private func configureDependencies() {
        
        let authManager: AuthManagerProtocol = AuthManager()
        let signInUseCase: SignInUseCaseProtocol = SignInUseCase(authManager: <#T##any AuthManager#>)
        SignInViewModel(signInUseCase: <#T##any AuthUseCase#>)
    }
}
