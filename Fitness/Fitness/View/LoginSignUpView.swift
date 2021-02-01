//
//  LoginSignUpView.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct LoginSignUpView: View {
    @ObservedObject var viewModel: LoginSignUpViewModel
    
    var emailTextField: some View {
        TextField("Email", text: $viewModel.email)
            .modifier(TextfieldRoundedStyle())
    }
    
    var passwordTextField: some View {
        SecureField("Password", text: $viewModel.password)
            .modifier(TextfieldRoundedStyle())
    }
    
    var actionButton: some View {
        Button(action: {}) {
            Text(viewModel.buttonTitle)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(.systemPink))
        .cornerRadius(16)
        .padding()
    }
    
    var body: some View {
        VStack{
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(viewModel.subtitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            
            Spacer()
                .frame(height: 50)
            
            emailTextField
            passwordTextField
            actionButton
            
            Spacer()
        }
    }
}
