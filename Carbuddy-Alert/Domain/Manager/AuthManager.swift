//
//  AuthManager.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/26/25.
//

protocol authManagerProtocol {
    func signIn(with provider: AuthProvider)
}


final class AutAuthManager: authManagerProtocol {
    
    private lazy var firebaseAuth: Auth = { return Auth.auth() }()
    
    private init(){
        
    }
    func signIn(with provider: AuthProvider) {
        
    }
}
