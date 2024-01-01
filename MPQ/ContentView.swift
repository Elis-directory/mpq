//
//  ContentView.swift
//  MPQ
//

import SwiftUI

// add ability to choose color by hex value
extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

// struct repesenting element in queuw
struct QueuedItem {
    var title = "Title"
    var description = "Description"
    var count = "Count"
    var containerWidth = 0.0
    var containerHeight = 0.0
    var backgroundColor = Color.white
    
    func display() -> some View {
        ZStack {
            Rectangle()
                .frame(width: CGFloat(containerWidth), height: CGFloat(containerHeight))
                .foregroundColor(backgroundColor)
                .cornerRadius(6.0)
            Text(title)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }
}


// UI color pallete
var urgentColor = Color(hex: 0xE84258)
var semiUrgentColor = Color(hex: 0xFEE191)
var nonUrgentColor = Color(hex: 0xB0D8A4)
var backgroundColor = Color(hex: 0xFCFCFC)

// screen dimensions
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
var modalActive = true



struct ContentView: View {
    @State private var isSheetPresented = false
    @State private var isModalPresented = false
    @State private var itemTitle = ""
    @State private var itemUrgency = ""
    @State private var itemDescription = ""
    @State private var queuedItem = QueuedItem()
    @State private var queuedItems: [QueuedItem] = []
    @State private var selectedDurationIndex = 0
    @State private var selectedUrgencyIndex = 0
    
    let urgencies = ["Urgent", "Semi-urgent", "Non-urgent"]
    let durations = ["30 sec", "1 min", "2 min", "5 min"]
    
    
    var body: some View {
            ZStack {
                Image("Logo").resizable()
                    .frame(width: screenWidth, height: screenHeight * 0.4)
                    .offset(y: screenHeight * -0.2)
                VStack {
                    Rectangle()
                        .foregroundColor(Color.blue.opacity(0))
                        .frame(width: screenWidth, height: screenHeight * 0.25)
                        .alignmentGuide(.top) { _ in
                              screenHeight * 0.25
                          }
                    
                    ForEach(queuedItems.indices, id: \.self) { index in
                        queuedItems[index].display()
                            .onAppear {
                                queuedItems[index].containerWidth = screenWidth
                                queuedItems[index].containerHeight = screenHeight * 0.1
                            }
                            .onTapGesture {
                                if modalActive {
                                    queuedItems[index].containerWidth = screenWidth * 0.95
                                    queuedItems[index].containerHeight = screenHeight * 0.3
                                    modalActive = false
                                } else {
                                    queuedItems[index].containerWidth = screenWidth
                                    queuedItems[index].containerHeight = screenHeight * 0.1
                                    modalActive = true
                                }
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
                }

                
            }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .sheet(isPresented: $isSheetPresented) {
            VStack {
                HStack {
                    Text("Urgency")
                        .font(.system(size: 30))
                        .foregroundColor(Color(hex: 0xFFC7C7CC))
                               
                    Spacer()
                               
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(urgentColor)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                selectedUrgencyIndex = 0
                                        
                            }
                        Rectangle()
                            .fill(semiUrgentColor)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                selectedUrgencyIndex = 1
                            }
                                   
                            Rectangle()
                                .fill(nonUrgentColor)
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    selectedUrgencyIndex = 2
                            }
                        }
                               
                               
                    }
                    .padding()
               
               
//                TextField("Title", text: $itemTitle).font(.system(size: 30)).padding()
                TextField("Description", text: $itemDescription).font(.system(size: 30)).padding()
                
                HStack {
                    Text("Duration").font(.system(size:30)).foregroundColor(Color(hex: 0xFFC7C7CC))
                              Spacer()
                              Picker(selection: $selectedDurationIndex, label: Text("Duration")) {
                                  ForEach(0..<durations.count, id: \.self) { index in
                                      Text(durations[index]).tag(index)
                                  }
                              }
                              .pickerStyle(MenuPickerStyle())
                              .frame(width: 120)
                          }
                          .padding()
              
            
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
