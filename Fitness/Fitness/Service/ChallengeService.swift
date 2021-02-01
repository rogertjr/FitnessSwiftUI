//
//  ChallengeService.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError>
}

class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
                return promise(.success(()))
            } catch {
                return promise(.failure(.default()))
            }
        }
        .eraseToAnyPublisher()
    }
}
