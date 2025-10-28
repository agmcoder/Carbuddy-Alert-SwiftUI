//
//  SignInViewModel.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/19/25.
//
import Combine
protocol SignInViewModelProtocol {
    var isRadarPulseAnimating: Bool { get set }
    var isLogoPulseAnimating: Bool { get set }
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    
    func signIn(with provider: AuthProvider)
}

typealias SignInViewModelProtocolWithPublished = SignInViewModelProtocol & ObservableObject
final class SignInViewModel: SignInViewModelProtocolWithPublished{
    private let logger = LoggerService()
    
    @Published var isRadarPulseAnimating = false
    @Published var isLogoPulseAnimating = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let signInUseCase: SignInUseCaseProtocol
    
    init(signInUseCase: SignInUseCaseProtocol) {
        self.signInUseCase = signInUseCase
    }
    
    func signIn(with provider: AuthProvider) {
        logger.log(.debug, "started sign in", .auto)
        signInUseCase.execute(with: provider)
        
    }

}
