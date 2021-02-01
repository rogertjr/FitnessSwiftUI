//
//  ChallengeListView.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var vm = ChallengeListViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                LazyVGrid(columns: [.init(.flexible()),.init(.flexible())]) {
                    ForEach(vm.itemViewModels, id: \.self) { viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
        }
        .navigationTitle(vm.title)
    }
}

struct ChallengeItemView: View {
    private let viewModel: ChallengeItemViewModel
    
    init(viewModel: ChallengeItemViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 24, weight: .bold))
                Text(viewModel.statusText)
                Text(viewModel.increaseText)
            }
            .padding()
            Spacer()
        }
        .background(Rectangle().fill(Color.darkPrimaryButton).cornerRadius(5))
        .padding()
    }
}
