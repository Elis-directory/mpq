//
//  ContentView.swift
//  MPQ
//

import SwiftUI
extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
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
    let backgroundColor = Color(hex: 0xFFFFFF)
    let urgentColor = Color(hex: 0xE84258)
    let semiUrgentColor = Color(hex: 0xFEE191)
    let nonUrgentColor = Color(hex: 0xB0D8A4)
   
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("MPQ")
                    .font(.system(size: 60))
                    .padding()
                
                queuedItem.display() .onAppear {
                    queuedItem.containerWidth = Double(geometry.size.width) // Update containerWidth
                    queuedItem.containerHeight = Double(geometry.size.height) * 0.1 // Update containerHeight
                    queuedItem.backgroundColor = urgentColor
                }
                queuedItem2.display()
                    .onAppear {
                    queuedItem2.containerWidth = Double(geometry.size.width) // Update containerWidth
                    queuedItem2.containerHeight = Double(geometry.size.height) * 0.1 // Update containerHeight
                    queuedItem2.backgroundColor = semiUrgentColor
                }
                
                queuedItem3.display()
                    .onAppear {
                    queuedItem3.containerWidth = Double(geometry.size.width) // Update containerWidth
                    queuedItem3.containerHeight = Double(geometry.size.height) * 0.1 // Update containerHeight
                    queuedItem3.backgroundColor = nonUrgentColor
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
           
        }.background(backgroundColor)
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
