//
//  CustomTextField.swift
//  CarBuddy_Alert
//
//  Created by agmcoder on 9/26/25.
//

import SwiftUI

struct CustomTextField: View {
    
    private let textOpacity = 0.7    // Title text opacity
    
    // Input Configuration
    let title: String                // Field label
    let hint: String                 // Placeholder text
    let icon: String?                // SF Symbol name for icon
    let isSecure: Bool               // Secure entry toggle
    
    // State Management
    @Binding var text: String        // Two-way data binding
    @State private var isShowPassword: Bool = false   // Password visibility
    @FocusState private var isFocused: Bool           // Focus state

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .opacity(textOpacity)
            
            HStack(spacing: 8) {
                if let icon, !icon.isEmpty {
                    Image(systemName: icon)
                        .foregroundStyle(.secondary)
                }
                
                Group {
                    if isSecure && !isShowPassword {
                        SecureField(hint, text: $text)
                            .focused($isFocused)
                    } else {
                        TextField(hint, text: $text)
                            .focused($isFocused)
                    }
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                if isSecure {
                    Button {
                        isShowPassword.toggle()
                    } label: {
                        Image(systemName: isShowPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(isFocused ? Color.accentColor.opacity(0.8) : Color.secondary.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        CustomTextField(
            title: "Email",
            hint: "name@example.com",
            icon: "envelope",
            isSecure: false,
            text: .constant("")
        )
        CustomTextField(
            title: "Password",
            hint: "Enter your password",
            icon: "lock",
            isSecure: true,
            text: .constant("")
        )
    }
    .padding()
}


