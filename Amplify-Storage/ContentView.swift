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
    @State var fileStatus: String?

    var body: some View {
        if let fileStatus = self.fileStatus {
            Text(fileStatus)
        }
        Button("Upload File", action: uploadFile).padding()
        
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
    }
    func uploadFile() {
        let fileKey = "testFile.txt"
        let fileContents = "This is my dummy file"
        let fileData = fileContents.data(using: .utf8)!
        
        Amplify.Storage.uploadData(
            key: fileKey,
            data: fileData)
        
        { result in
            
            switch result {
            case .success(let key):
                print("File with key \(key) uploaded")
                
                DispatchQueue.main.async {
                    fileStatus = "File uploaded"
                }
                
            case .failure(let storageError):
                print("Failed to upload file", storageError)
               
                DispatchQueue.main.async {
                    fileStatus = "Failed to upload file"
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
