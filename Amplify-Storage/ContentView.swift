//
//  ContentView.swift
//  Amplify-Storage
//
//  Created by Georgina Contreras-Keenan on 09/08/2024.
//

import Amplify
import Authenticator
import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = TodoViewModel()
    
    var body: some View {
        Authenticator { state in
            VStack {
                Button("Sign out") {
                    Task {
                        await state.signOut()
                    }
                }
                
                List {
                 ForEach($vm.todos, id: \.id) { todo in
                        TodoRow(vm: vm, todo: todo)
                    }
                    .onDelete { indexSet in
                        Task { await vm.deleteTodos(indexSet: indexSet) }
                    }
                }
                .task {
                    await vm.listTodos()
                }
                
                Button(action: {
                    Task { await vm.createTodo() }
                }) {
                    HStack {
                        Text("Add a New Todo")
                        Image(systemName: "plus")
                    }
                }
                .accessibilityLabel("New Todo")
            }
        }
        do {
            let dataString = "MyData"
            let data = Data(dataString.utf8)
            let uploadTask = try await Amplify.Storage.uploadData(
                key: "ExampleKey",
                data: data
            )
            
            Task {
                for await progress in await uploadTask.progress {
                    print("Progress: \(progress)")
                }
            }
            
            let value = try await uploadTask.value
            print("Completed: \(value)")
        } catch let error as StorageError {
            print("Failed: \(error.errorDescription). \(error.recoverySuggestion)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
#Preview {
    ContentView()
}
