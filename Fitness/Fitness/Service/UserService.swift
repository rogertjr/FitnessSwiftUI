//
//  UserService.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import FirebaseAuth
import Combine

protocol UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?,Never>
    func sigInAnon() -> AnyPublisher<User,IncrementError>
    func observerAuthChanges() -> AnyPublisher<User?, Never>
}

class UserService: UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func sigInAnon() -> AnyPublisher<User, IncrementError> {
        return Future<User, IncrementError> { promise in
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    return promise(.failure(.auth(description: error.localizedDescription)))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func observerAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
    
    
}
