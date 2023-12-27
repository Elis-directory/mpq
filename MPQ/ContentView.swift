//
//  ContentView.swift
//  MPQ
//

import SwiftUI

struct ContentView: View {
    @State private var showText = false
    @State private var isSheetPresented = false
    @State private var itemTitle = ""
    @State private var itemCount = ""
    @State private var itemDescription = ""
    
    struct queuedItem {
        var title = ""
        var description = ""
        var count = ""
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("MPQ")
                .font(.system(size: 60))
                .padding()
                Spacer()
                       
                VStack {
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image(systemName: "plus.app.fill")
                        .font(.system(size: 60))
                        }
                           
                }
                .padding()
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            HStack {
                TextField("Title", text: $itemTitle).font(.system(size: 30)).padding()
            }
            TextField("Count", text: $itemCount).font(.system(size: 30)).padding()
            TextField("Description", text: $itemDescription).font(.system(size: 30)).padding()
            Spacer()
            Button(action: {
                isSheetPresented.toggle()
            }, label: {
                Image(systemName: "chevron.up.circle.fill")
                .font(.system(size: 60))
            })
        }
       
    }
}

#Preview {
    ContentView()
}
