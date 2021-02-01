//
//  FitnessApp.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI
import Firebase

@main
struct FitnessApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabView {
                    Text("logged in")
                        .tabItem {
                            Image(systemName: "book")
                        }
                }
                .accentColor(.primary)
            } else {
                LandingView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

class AppState: ObservableObject {
    @Published private(set) var isLoggedIn = false
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
        try? Auth.auth().signOut()
        userService
            .observerAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
    }
}
