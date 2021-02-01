//
//  CreateView.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct CreateView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                DropDownView()
                DropDownView()
                DropDownView()
                DropDownView()
                
                Spacer()
                
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: { isActive = true }, label: {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    })
                }
            }
            .navigationBarTitle("Create")
            .navigationBarHidden(true)
            .padding(.bottom, 15)
        }
    }
}
