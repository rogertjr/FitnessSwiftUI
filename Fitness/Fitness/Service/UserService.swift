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
    func sigInAnon() -> AnyPublisher<User,Error>
}

class UserService: UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func sigInAnon() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    return promise(.failure(error))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
}
