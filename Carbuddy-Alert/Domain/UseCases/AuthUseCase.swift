//
//  AuthUseCase.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/22/25.
//

protocol SignInUseCaseProtocol {
    func execute(with provider: AuthProvider)
}

final class SignInUseCase: SignInUseCaseProtocol {
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func execute(with provider: AuthProvider) {
        
    }
}
