//
//  Auth.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/27/25.
//

import FirebaseCore
import GoogleSignIn

protocol FirebaseRepositoryProtocol {
    
    func signIn()
        
}

final class FirebaseRepository : FirebaseRepositoryProtocol {
    
    private let googleSignInHelper: GoogleSignInProtocol
    
    private init(googleSignInHelper: GoogleSignInProtocol = GoogleSignInHelper()) {
        self.googleSignInHelper = googleSignInHelper
    }
    
    func signIn() {
        
    }
}

protocol GoogleSignInProtocol {
    
    func configurateGoogleSignIn() -> GIDConfiguration?
}

final class GoogleSignInHelper : GoogleSignInProtocol {
    
//    fileprivate let config: GIDConfiguration?
    
    init() {}

    internal func configurateGoogleSignIn() -> GIDConfiguration? {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil }
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        return GIDSignIn.sharedInstance.configuration
    }
    
    func signIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
          guard error == nil, let user = result?.user,
                let idToken = user.idToken?.tokenString else { return }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
          // Completa el inicio de sesión con Firebase
          Auth.auth().signIn(with: credential) { authResult, error in
            // Aquí el usuario ya ha iniciado sesión en Firebase
            if let error = error {
              print("Error en Firebase Auth: \(error.localizedDescription)")
              return
            }
            print("Usuario iniciado sesión con Firebase y Google.")
          }
        }

    }
}
