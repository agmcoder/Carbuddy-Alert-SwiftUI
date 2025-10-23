//
//  AuthUseCase.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/22/25.
//

protocol AuthUseCase {
    func execute(with provider: AuthProvider) async -> Bool
}

final class AuthUseCaseStrategy: AuthUseCase {
    func execute(with provider: AuthProvider) async -> Bool {
        return true
    }
}
