//
//  LoginSignUpViewModel.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import Foundation

class LoginSignUpViewModel: ObservableObject {
    private let mode: Mode
    
    @Published var email = ""
    @Published var password = ""
    @Published var isValid =  false
    
    init(mode: Mode){
        self.mode = mode
    }
    
    var title: String {
        switch mode {
        case .login:
            return "Welcome back!"
        case .signup:
            return "Create an Account"
        }
    }
        
    var subtitle: String {
        switch mode {
        case .login:
            return "Login with your email"
        case .signup:
            return "Signup via email"
        }
    }
    
    var buttonTitle: String {
        switch mode {
        case .login:
            return "Login"
        case .signup:
            return "Signup"
        }
    }
}

extension LoginSignUpViewModel {
    enum Mode {
        case login
        case signup
    }
}
