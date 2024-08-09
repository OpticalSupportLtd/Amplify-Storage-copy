//
//  Amplify_StorageApp.swift
//  Amplify-Storage
//
//  Created by Georgina Contreras-Keenan on 09/08/2024.
//
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import SwiftUI
import Authenticator

@main
struct Amplify_StorageApp: App {
    
    init() {
        let awsApiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: awsApiPlugin)
            try Amplify.configure(with: .amplifyOutputs)
        } catch {
            print("Unable to configure Amplify \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
