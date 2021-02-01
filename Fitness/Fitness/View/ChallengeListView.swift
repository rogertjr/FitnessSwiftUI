//
//  ChallengeListView.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var vm = ChallengeListViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else if let error = vm.error {
                VStack {
                    Text(error.localizedDescription)
                    Button(action: { vm.send(action: .retry) } ) {
                        Text("Retry")
                    }
                    .padding(10)
                    .background(Rectangle().fill(Color.red).cornerRadius(5))
                }
            } else {
                mainContentView
            }
        }
    }
    
    var mainContentView: some View {
        ScrollView{
            VStack {
                LazyVGrid(columns: [.init(.flexible(), spacing: 20),.init(.flexible())], spacing: 20) {
                    ForEach(vm.itemViewModels, id: \.self) { viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
            .padding(10)
        }
        .sheet(isPresented: $vm.showingCreateModal) {
            NavigationView {
                CreateView()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .navigationBarItems(trailing: Button(action: { vm.send(action: .create) }, label: {
            Image(systemName: "plus.circle").imageScale(.large)
        }))
        .navigationTitle(vm.title)
    }
    
}

struct ChallengeItemView: View {
    private let viewModel: ChallengeItemViewModel
    
    init(viewModel: ChallengeItemViewModel){
        self.viewModel = viewModel
    }
    
    var titleRow: some View {
        HStack{
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Image(systemName: "trash")
        }
    }
    
    var dailyIncreaseRow: some View {
        HStack {
            Text(viewModel.increaseText)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                titleRow
                Text(viewModel.statusText)
                    .font(.system(size: 12, weight: .bold))
                    .padding(25)
                dailyIncreaseRow
            }
            .padding(.vertical, 10)
            Spacer()
        }
        .background(Rectangle().fill(Color.primaryButton).cornerRadius(5))
    }
}
