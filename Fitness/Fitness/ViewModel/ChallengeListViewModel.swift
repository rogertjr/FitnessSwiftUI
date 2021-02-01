//
//  ChallengeListViewModel.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI
import Combine

class ChallengeListViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var itemViewModels: [ChallengeItemViewModel] = []
    let title: String = "Challenges"
    
    init(userService: UserServiceProtocol = UserService(), challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    private func observeChallenges() {
        userService
            .currentUser()
            .compactMap { $0?.uid }
            .flatMap { userID -> AnyPublisher<[Challenge], IncrementError> in
                return self.challengeService.observeChallenges(userID: userID)
            }
            .sink{ completion in
               switch completion {
               case let .failure(error):
                    print(error.localizedDescription)
               case .finished:
                    print("finished")
               }
            } receiveValue: { challenges in
                self.itemViewModels = challenges.map { .init($0) }
            }
            .store(in: &cancellables)
    }
}
