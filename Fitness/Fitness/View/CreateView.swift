//
//  CreateView.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct CreateView: View {
    @StateObject var vm = ChallengeViewModel()
    
    var dropDownList: some View {
        Group {
            DropDownView(viewModel: $vm.exerciseDropDown)
            DropDownView(viewModel: $vm.startAmountDropDown)
            DropDownView(viewModel: $vm.increaseDropDown)
            DropDownView(viewModel: $vm.lengthDropDown)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropDownList
                Spacer()
                
                Button(action: {
                    vm.send(action: .createChallenge)
                }, label: {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                })
            }
            .navigationBarTitle("Create")
            .navigationBarHidden(true)
            .padding(.bottom, 15)
        }
    }
}
