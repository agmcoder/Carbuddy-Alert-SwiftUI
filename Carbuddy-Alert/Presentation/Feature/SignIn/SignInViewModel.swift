//
//  SignInViewModel.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/19/25.
//
import Combine

final class SignInViewModel: ObservableObject {
    @Published var isRadarPulseAnimating = false
    @Published var isLogoPulseAnimating = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let signInUseCase: AuthUseCase
    
    init(signInUseCase: AuthUseCase) {
        self.signInUseCase = signInUseCase
    }
    
    @MainActor
    func signIn(with provider: AuthProvider) async {}

}
