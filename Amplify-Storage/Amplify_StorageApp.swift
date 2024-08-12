//
//  Amplify_StorageApp.swift
//  Amplify-Storage
//
//  Created by Georgina Contreras-Keenan on 09/08/2024.
//
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import AWSS3StoragePlugin
import SwiftUI
import Authenticator

@main
struct Amplify_StorageApp: App {
    
    init() {
        let awsApiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: awsApiPlugin)
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure(with: .amplifyOutputs)
            
            print("Amplify configured with auth plugin")
                            
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
