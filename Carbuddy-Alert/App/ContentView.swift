//
//  ContentView.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/3/25.
//

import SwiftUI

struct ContentView: View {
    private let SignInViewModel: SignInViewModel = .init(signInUseCase: () as! AuthUseCase)
    var body: some View {
        SignInView(viewModel: <#SignInViewModel#>)
    }
}

#Preview {
    ContentView()
}
