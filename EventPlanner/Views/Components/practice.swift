//
//  practice.swift
//  EventPlanner
//
//  Created by Chicmic on 05/06/23.
//

import SwiftUI

struct InitialView: View {
    @State private var showNestedView = false
    
    var body: some View {
        VStack {
            Button("Open Nested View") {
                showNestedView = true
            }
            .padding()
            
            NavigationLink(destination: NestedView(), isActive: $showNestedView) {
                EmptyView()
            }
        }
    }
}

struct NestedView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Button("Pop All Views") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            
            NavigationLink(destination: FinalView()) {
                Text("Go to Final View")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct FinalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Final View")
                .font(.headline)
                .padding()
            
            Button("Pop All Views") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

struct ContentView2: View {
    var body: some View {
        NavigationView {
            InitialView()
                .navigationTitle("Initial View")
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
