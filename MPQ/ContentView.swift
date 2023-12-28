//
//  ContentView.swift
//  MPQ
//

import SwiftUI

struct ContentView: View {
    @State private var isSheetPresented = false
    @State private var itemTitle = ""
    @State private var itemCount = ""
    @State private var itemDescription = ""
    
    struct QueuedItem {
        var title = "Title"
        var description = "Description"
        var count = "Count"
        var containerWidth = 0.0
        var containerHeight = 0.0
        var backgroundColor = Color.white
        
        func display() -> some View {
           
                Text(title)
                    .frame(width: CGFloat(containerWidth), height: CGFloat(containerHeight))
                    .background(backgroundColor)
                    
                  
           
        }
    }
    
    @State private var queuedItem = QueuedItem()
    @State private var queuedItem2 = QueuedItem()// Create an instance
    @State private var queuedItem3 = QueuedItem()// Create an instance
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("MPQ")
                    .font(.system(size: 60))
                    .padding()
                
                queuedItem.display() .onAppear {
                    queuedItem.containerWidth = Double(geometry.size.width) // Update containerWidth
                    queuedItem.containerHeight = Double(geometry.size.height) * 0.1 // Update containerHeight
                    queuedItem.backgroundColor = Color.red
                }
                queuedItem2.display()
                    .onAppear {
                    queuedItem2.containerWidth = Double(geometry.size.width) // Update containerWidth
                    queuedItem2.containerHeight = Double(geometry.size.height) * 0.1 // Update containerHeight
                    queuedItem2.backgroundColor = Color.yellow
                }
                
                queuedItem3.display()
                    .onAppear {
                    queuedItem3.containerWidth = Double(geometry.size.width) // Update containerWidth
                    queuedItem3.containerHeight = Double(geometry.size.height) * 0.1 // Update containerHeight
                    queuedItem3.backgroundColor = Color.green
                }
              
                Spacer()
                
                VStack {
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image(systemName: "plus.app.fill")
                            .font(.system(size: 60))
                    }
                    .padding()
                }
            }
           
        }
        .sheet(isPresented: $isSheetPresented) {
            VStack {
                TextField("Title", text: $itemTitle).font(.system(size: 30)).padding()
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
}

#Preview {
    ContentView()
}
