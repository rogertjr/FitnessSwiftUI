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
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error>
}

class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge)
                return promise(.success(()))
            } catch {
                return promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
