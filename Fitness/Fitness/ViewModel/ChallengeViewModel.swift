//
//  ChallengeViewModel.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

final class ChallengeViewModel: ObservableObject {
    @Published var dropDowns: [ChallengePartViewModel] = [ .init(type: .exercise), .init(type: .startAmount), .init(type: .increase), .init(type: .length) ]
    
    enum Action {
        case selectOption(index: Int)
    }
    
    var hasSelectedDropdown: Bool {
        selectedDropDownIndex != nil
    }
    
    var selectedDropDownIndex: Int? {
        dropDowns.enumerated().first(where: {$0.element.isSelected})?.offset
    }
    
    var displayOptions: [DropdownOption] {
        guard let selectedDropDownIndex = selectedDropDownIndex else { return []}
        return dropDowns[selectedDropDownIndex].options
    }
    
    func send(action: Action){
        switch action {
        case let .selectOption(index):
            guard let selectedDropDownIndex = selectedDropDownIndex else { return }
            clearSelectedOption()
            dropDowns[selectedDropDownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        }
    }
    
    func clearSelectedOption() {
        guard let selectedDropDownIndex = selectedDropDownIndex else { return }
        dropDowns[selectedDropDownIndex].options.indices.forEach { index in
            dropDowns[selectedDropDownIndex].options[index].isSelected = false
        }
    }
    
    func clearSelectedDropdown() {
        guard let selectedDropDownIndex = selectedDropDownIndex else { return }
        dropDowns[selectedDropDownIndex].isSelected = false
    }
}

extension ChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            options.first(where: {$0.isSelected})?.formatted ?? ""
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
                .init(type: .text(rawValue), formatted: rawValue.capitalized, isSelected: self == .pullups)
            }
        }
        
        enum StartAmountOption: Int,CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: String(rawValue), isSelected: self == .one)
            }
        }
        
        enum DailyIncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)", isSelected: self == .one)
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) days", isSelected: self == .seven)
            }
        }
    }
}
