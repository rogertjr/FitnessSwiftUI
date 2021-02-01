//
//  LoginSignUpViewModel.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI
import Combine

class LoginSignUpViewModel: ObservableObject {
    private let mode: Mode
    
    @Published var email = ""
    @Published var password = ""
    @Published var isValid =  false
    
    @Binding var isPushed: Bool
    
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    private(set) var emailPlaceholderText = "Email"
    private(set) var passwordPlaceholderText = "Password"
    
    init(mode: Mode, userService: UserServiceProtocol = UserService(), isPushed: Binding<Bool>){
        self.mode = mode
        self.userService = userService
        self._isPushed = isPushed
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
    
    func tappedActionButton() {
        switch mode {
        case .login:
            print("login")
        case .signup:
            userService.linkAccount(email: email, password: password)
                .sink { [weak self] (completion) in
                    switch completion {
                    case let .failure(error):
                        print(error.localizedDescription)
                    case  let .finished:
                        self?.isPushed = false
                        print("finished")
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)
        }
    }
}

extension LoginSignUpViewModel {
    enum Mode {
        case login
        case signup
    }
}
