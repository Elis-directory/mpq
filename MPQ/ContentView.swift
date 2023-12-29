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
    @State private var itemUrgency = ""
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
                .multilineTextAlignment(.leading)
                .frame(width: CGFloat(containerWidth), height: CGFloat(containerHeight))
                .background(backgroundColor)
        }


    }
    
    @State private var queuedItem = QueuedItem()

    let backgroundColor = Color(hex: 0xFFFFFF)
    let urgentColor = Color(hex: 0xE84258)
    let semiUrgentColor = Color(hex: 0xFEE191)
    let nonUrgentColor = Color(hex: 0xB0D8A4)
    var cubeColor = Color(hex: 0xB0D8A4)
    var containerWidth = 0.0
    var containerHeight = 0.0
    @State private var queuedItems: [QueuedItem] = []
    
   
    
    var body: some View {
      
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        VStack() {
            Text("MPQ")
                .font(.system(size: 60))
                .multilineTextAlignment(.center)
                .padding()
            
            ForEach(queuedItems.indices, id: \.self) { index in
                queuedItems[index].display()
                .onAppear {
                    queuedItems[index].containerWidth = screenWidth
                    queuedItems[index].containerHeight = screenHeight * 0.1
                    }
               
           
            }
            Spacer()
           
                Button(action: {
                    isSheetPresented.toggle()
                }) {
                    Image(systemName: "plus.app.fill")
                        .font(.system(size: 60))
                }
                .padding()
         
           
        }.background(backgroundColor)
        .sheet(isPresented: $isSheetPresented) {
            
            VStack {
               
                TextField("Title", text: $itemTitle).font(.system(size: 30)).padding()
                TextField("Urgency", text: $itemUrgency).font(.system(size: 30)).padding()
                TextField("Description", text: $itemDescription).font(.system(size: 30)).padding()
                
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                    
                    var queuedItem = QueuedItem(title: itemTitle, description: itemDescription)
                    if(itemUrgency == "1") {
                        queuedItem.backgroundColor = urgentColor
                       
                    }
                    
                    if(itemUrgency == "2") {
                        queuedItem.backgroundColor = semiUrgentColor
                        
                    }
                    
                    if(itemUrgency == "3") {
                        queuedItem.backgroundColor = nonUrgentColor
                        
                    }
                    queuedItems.append(queuedItem)
                    
                    
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
