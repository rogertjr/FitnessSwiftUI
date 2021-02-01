//
//  SettingsViewModel.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published private(set) var itemViewModels: [SettingsItemViewModel] = []
    @Published var loginSignUpPushed = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    let title: String = "Settings"
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int){
        switch itemViewModels[index].type {
        case .account:
            loginSignUpPushed = true
        case .mode:
            isDarkMode = !isDarkMode
            buildItems()
        default:
            break
        }
    }
    
    private func buildItems() {
        itemViewModels = [
            .init(title: "Create Account", iconName: "person.circle", type: .account),
            .init(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy),
        ]
    }
    
    func onAppear() {
        buildItems()
    }
}
