//
//  ChallengeViewModel.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI
import Combine

typealias UserID = String

final class ChallengeViewModel: ObservableObject {
    @Published var exerciseDropDown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropDown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropDown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropDown = ChallengePartViewModel(type: .length)
    
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func send(action: Action){
        switch action {
        case .createChallenge:
            currentUserID()
                .sink { (completion) in
                    switch completion {
                    case let .failure(error):
                        print(error.localizedDescription)
                    case .finished:
                        print("completed")
                    }
                } receiveValue: { (userID) in
                    print("retrieved user ID \(userID)")
                }
                .store(in: &cancellables)

        }
    }
    
    private func currentUserID() -> AnyPublisher<UserID, Error> {
        return userService.currentUser().flatMap { user -> AnyPublisher<UserID, Error> in
            if let userID = user?.uid {
                return Just(userID)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return self.userService
                    .sigInAnon()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}

extension ChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        
        private let type: ChallengePartType
        
        init(type: ChallengePartType){
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map { $0.toDropdownOption}
            case .startAmount:
                self.options = StartAmountOption.allCases.map { $0.toDropdownOption}
            case .increase:
                self.options = DailyIncreaseOption.allCases.map { $0.toDropdownOption}
            case .length:
                self.options = LengthOption.allCases.map { $0.toDropdownOption}
            }
            
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Stating Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue), formatted: rawValue.capitalized)
            }
        }
        
        enum StartAmountOption: Int,CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: String(rawValue))
            }
        }
        
        enum DailyIncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)")
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) days")
            }
        }
    }
}
