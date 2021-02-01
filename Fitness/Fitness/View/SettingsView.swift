//
//  SettingsView.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    
    var body: some View {
        List(viewModel.itemViewModels.indices, id: \.self){ index in
            Button(action: {
                viewModel.tappedItem(at: index)
            }) {
                HStack {
                    Image(systemName: viewModel.item(at: index).iconName)
                    Text(viewModel.item(at: index).title)
                }
            }
        }
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.onAppear()
        }
    }
}