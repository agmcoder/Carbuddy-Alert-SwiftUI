//
//  CustomProviderButton.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/7/25.
//

import SwiftUI

struct AuthButton: View {
    let action: () -> Void
    let provider: AuthProvider
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSize.spacing(.low)) {
                provider.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: AppSize.iconSize(.xLarge))
                
                Text(buildButtonTittle(for: provider))
                    .font(.system(size: 20, weight: .heavy))
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .glassEffect(.regular.interactive().tint(provider.backgroundColor), in: .capsule)
        .foregroundStyle(provider.textColor)
    }
    
    
    private func buildButtonTittle(for provider: AuthProvider) -> String {
        let signInFormat = String(localized: "signIn.provider.button", defaultValue: "Sign in with %@")
        let providerTitle = provider.title
        return signInFormat + providerTitle
    }
}

enum AuthProvider: CaseIterable {
    case google
    case apple
    case email
    
    var title: String {
        switch self {
        case .google: return "Google"
        case .apple: return "Apple"
        case .email: return "Email"
        }
    }
    
    var icon: Image {
        switch self {
        case .google: return Image(.googleLogo)
        case .apple: return Image(.appleLogo)
        case .email: return Image(.emailIcon)
        }
    }
    
    var backgroundColor: Color? {
        switch self {
        case .google: return Color.googleWhite
        case .apple: return Color.appleBlack
        case .email: return Color.clear
        }
    }
    
    var textColor: Color {
        switch self {
        case .google: return Color.black
        case .apple: return Color.white
        case .email: return Color.black
        }
    }
}

#Preview {
    ZStack{
        Color.blue.edgesIgnoringSafeArea(.all)
        VStack {
            AuthButton(action: {}, provider: .apple)
            AuthButton(action: {}, provider: .google)
            AuthButton(action: {}, provider: .email)
        }
    }
}

