//
//  CreateView.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct CreateView: View {
    @StateObject var vm = ChallengeViewModel()
    @State private var isActive: Bool = false
    
    var dropDownList: some View {
        ForEach(vm.dropDowns.indices, id: \.self){ index in
            DropDownView(viewModel: $vm.dropDowns[index])
        }
    }
    
    var dropDownActionSheet: ActionSheet {
        ActionSheet(title: Text("Select"), buttons: vm.displayOptions.indices.map{ index in
                let option = vm.displayOptions[index]
                return ActionSheet.Button.default(Text(option.formatted)) {
                    vm.send(action: ChallengeViewModel.Action.selectOption(index: index))
                }
        })
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropDownList
                Spacer()
                
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: { isActive = true }, label: {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    })
                }
            }
            .actionSheet(isPresented: Binding<Bool>(get: { vm.hasSelectedDropdown }, set: {_ in}) ) {
                dropDownActionSheet
            }
            .navigationBarTitle("Create")
            .navigationBarHidden(true)
            .padding(.bottom, 15)
        }
    }
}
