//
//  ContentView.swift
//  MPQ
//

import SwiftUI
import Foundation



// UI color pallete
var urgentColor = Color(hex: 0xE84258)
var semiUrgentColor = Color(hex: 0xFEE191)
var nonUrgentColor = Color(hex: 0xB0D8A4)
var backgroundColor = Color(hex: 0xFCFCFC)

// screen dimensions
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

// add ability to choose color by hex value on Color struct
extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

// struct for adding outline color to text
struct StrokeText: View {
    let text: String
    let width: CGFloat
    let outerColor: Color
    let innerColor: Color

    var body: some View {
        ZStack {
            ZStack {
                Text(text)
                    .offset(x: width, y: width)
                    .foregroundColor(outerColor)
                Text(text)
                    .offset(x: -width, y: -width)
                    .foregroundColor(outerColor)
                Text(text)
                    .offset(x: -width, y: width)
                    .foregroundColor(outerColor)
                Text(text)
                    .offset(x: width, y: -width)
                    .foregroundColor(outerColor)
            }
            .foregroundColor(outerColor)
            Text(text)
                .foregroundColor(innerColor)
        }
    }
}

// helper function to determine background color of a given queue black
func colorPicker(index: Int) -> Color {
    var backgroundColor: Color

    if index == 0 {
        backgroundColor = urgentColor
    } else if index == 1 {
        backgroundColor = semiUrgentColor
    } else if index == 2 {
        backgroundColor = nonUrgentColor
    } else {
        backgroundColor = .white
        print("Background Color Error!")
    }
    
    return backgroundColor
}


// function intended to display queue block to user
func display(containerWidth: Float, containerHeight: Float, tapped:  Binding<Bool>, title: String, description: String, backgroundColor: Color ) -> some View {
    
        VStack {
            if(tapped.wrappedValue) {

                ZStack {
    
                        Rectangle()
                        .frame(width: CGFloat(containerWidth), height: CGFloat(containerHeight * 2))
                            .foregroundColor(backgroundColor)
                            .cornerRadius(6.0)
                           
                    VStack {
                        StrokeText(text: title, width: 0.5, outerColor: .black, innerColor: Color(hex: 0xFCFCFC))
                            .font(.largeTitle)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        
                        ZStack {
                            Rectangle()
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.125)
                                .foregroundColor(Color(hex: 0xFCFCFC))
                                .offset(y: screenHeight * -0.025)
                            
                            
                            Text(description)
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(Color(hex: 0x000033))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: screenWidth * 0.8, minHeight: screenHeight * 0.045, alignment: .leading)
                                .offset(x: screenWidth * -0.025, y: screenHeight * -0.025)
                                .lineLimit(5) // Allow text to display multiple lines
                                .padding(.leading)
                        }
                    }
                      
                } .onTapGesture {
                    tapped.wrappedValue.toggle()
                }
            } else {
      
                ZStack {
                    
                    Rectangle()
                        .frame(width: CGFloat(containerWidth), height: CGFloat(containerHeight))
                        .foregroundColor(backgroundColor)
                        .cornerRadius(6.0)
                       
                    StrokeText(text: title, width: 0.5, outerColor: .black, innerColor: Color(hex: 0xFCFCFC))
                        .font(.largeTitle)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
               
                }.onTapGesture {
                    tapped.wrappedValue.toggle()
                }
            }
            
        }
        
    }


// class repesenting element in queue
class QueuedItem {
    var title: String?
    var description: String?
    var urgencyIndex: Int?
    var durationIndex: Int?
    
    
    var containerWidth: Double?
    var containerHeight: Double?
    
    var backgroundColor:Color?
    
    init(title: String? = nil, description: String? = nil, urgencyIndex: Int? = nil, durationIndex: Int? = nil, containerWidth: Double? = nil, containerHeight: Double? = nil) {
        self.title = title
        self.description = description
        self.urgencyIndex = urgencyIndex
        self.durationIndex = durationIndex
        self.containerWidth = containerWidth
        self.containerHeight = containerHeight
    }
    
    func update() {
        switch urgencyIndex {
            case 0:
                
                    urgencyIndex = 1
                
            case 1:
                
                    urgencyIndex = 2
                
            case 2:
              
                    print("Done!")
                
            default:
                break
        }
    }
    
}
    
    //    mutating func update() {
    //
    //            switch urgencyIndex {
    //            case 0:
    //                alarm = times[durations[durationIndex]]! / 3
    //                if checkTimeUp(minutes: Double(alarm)) {
    //                    urgencyIndex = 1
    //                }
    //            case 1:
    //                alarm = times[durations[durationIndex]]! / 2
    //                if checkTimeUp(minutes: Double(alarm)) {
    //                    urgencyIndex = 2
    //                }
    //            case 2:
    //                print("checking green")
    //                alarm = times[durations[durationIndex]]!
    //                print(alarm)
    //                if checkTimeUp(minutes: Double(alarm)) {
    //                    print("Done!")
    //                }
    //            default:
    //                break
    //            }
    //        }
    
    
    
    
    
    //    mutating func prioritize() {
    //        if(urgencyIndex == 0) {
    //            alarm = times[durations[durationIndex]]! / 3
    //            if (checkTimeUp(minutes: Double(alarm))) {
    //                urgencyIndex = 1
    //            }
    //
    //
    //
    //        }
    //
    //        if(urgencyIndex == 1) {
    //            alarm = times[durations[durationIndex]]! / 2
    //            if (checkTimeUp(minutes: Double(alarm))) {
    //                urgencyIndex = 2
    //            }
    //        }
    //
    //        if(urgencyIndex == 2) {
    //            alarm = times[durations[durationIndex]]!
    //            if(checkTimeUp(minutes: Double(alarm))) {
    //                title = "Done"
    //            }
    //
    //        }
    //    }
    
//    func startItemUpdateTimer() {
//            print("timer starting")
//            // Update the queued items here
//            for index in queuedItems.indices {
//                print("looping")
//                switch queuedItems[index].urgencyIndex {
//                case 0:
//                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]! / 3)), repeats: false) { _ in
//                        queuedItems[index].urgencyIndex = 1
//                    }
//                    // Store the timer in case you need to invalidate it later
//                    // You might want to store the timers in an array if needed
//                case 1:
//                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]! / 2)), repeats: false) { _ in
//                        queuedItems[index].urgencyIndex = 2
//                    }
//                case 2:
//                    print("checking green")
//                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]!)), repeats: false) { _ in
//                        print("Done!")
//                    }
//                default:
//                    break
//                }
//                // Store the timers if needed
//            }
//        }
    



//                    .onAppear {
//
//                        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(10), repeats: true) { _ in
//                                       startItemUpdateTimer()
//                                   }
//
////                        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(10, repeats: false) { _ in
////
////                        })
//                    }
               
    
                            // Update the queued items here
//                                                for index in queuedItems.indices {
//
//                                                    switch queuedItems[index].urgencyIndex {
//                                                    case 0:
//                                                        var timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]! / 3)), repeats: false) { _ in
//                                                            queuedItems[index].urgencyIndex = 1
//                                                        }
//
////                                                        alarm =
////                                                        if checkTimeUp(minutes: Double(alarm)) {
////
////                                                        }
//                                                    case 1:
//                                                        var timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]! / 2)), repeats: false) { _ in
//                                                            queuedItems[index].urgencyIndex = 2
//                                                        }
//                                                    case 2:
//                                                        print("checking green")
//                                                        var timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]!)), repeats: false) { _ in
//
//                                                            print("Done!")
//                                                        }
////
////                                                        alarm = times[durations[queuedItems[index].durationIndex]]!
////                                                        print(alarm)
////                                                        if checkTimeUp(minutes: Double(alarm)) {
////                                                            print("Done!")
////                                                        }
//                                                    default:
//                                                        break
//                                                    }
//
//
//                                            }
                 //   }
//                        .onAppear {
//                        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                            // Update the queued items here
//                            for index in queuedItems.indices {
//                                   queuedItems[index].update()
//                               }
//                        }
//                    }

    
        


struct ContentView: View {
    @State private var isSheetPresented = false
    @State private var isModalPresented = false
    @State private var darkenUrgent = false
    @State private var darkenSemiUrgent = false
    @State private var darkenNonUrgent = false
    @State private var isTapped = false
    
    
    
    @State private var itemTitle = ""
    @State private var itemUrgency = ""
    @State private var itemDescription = ""
    
    @State private var queuedItem = QueuedItem()
    @State private var queuedItems: [QueuedItem] = []
    
    @State private var selectedDurationIndex = 0
    @State private var selectedUrgencyIndex = 0
    @State var alarm = 0
   
   
    
    let urgencies = ["Urgent", "Semi-urgent", "Non-urgent"]
    let durations = ["1 min", "3 hours", "6 hours", "12 hours", "24 hours"]
    
    
    var times = [
        "1 min": 60,
        "3 hours": 180,
        "6 hours": 360,
        "12 hours": 720,
        "24 hours": 1440
    ]
    @State private var isTappedArray = Array(repeating: false, count: 12) // Assuming a default count


   
    
    // User View
    var body: some View {
        
            ZStack {
                Image("Logo").resizable()
                    .frame(width: screenWidth, height: screenHeight * 0.4)
                    .offset(y: screenHeight * -0.2)
                
                Text("Up to 12 items!")
                
                VStack {
                    Rectangle()
                        .foregroundColor(Color.blue.opacity(0))
                        .frame(width: screenWidth, height: screenHeight * 0.25)
                        .alignmentGuide(.top) { _ in
                              screenHeight * 0.25
                          }
                    
                    ScrollView {
                        
                        ForEach(queuedItems.indices, id: \.self) { index in
                            
                            display(containerWidth: Float(screenWidth) * 0.99, containerHeight: Float(screenHeight) * 0.1, tapped: $isTappedArray[index], title: queuedItems[index].title!, description: queuedItems[index].description!, backgroundColor: colorPicker(index: queuedItems[index].urgencyIndex!))
                                
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
                    TextField("Title", text: $itemTitle).font(.system(size: 30)).padding()
                
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
    
                
                    HStack {
                        Text("Urgency")
                            .font(.system(size: 30))
                            .foregroundColor(Color(hex: 0xFFC7C7CC))
                               
                    Spacer()
                   
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(urgentColor)
                            .frame(width: screenWidth * 0.075, height: screenHeight * 0.035)
                                   .opacity(darkenUrgent ? 0.5 : 1.0) // Darken by
                                   .onTapGesture {
                                       
                                       darkenUrgent = true
                                       
                                       // Reset the darkening effect after a delay
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                           darkenUrgent = false
                                       }
                                       
                                       selectedUrgencyIndex = 0
                                   }
                        
                        Rectangle()
                            .fill(semiUrgentColor)
                            .frame(width: screenWidth * 0.075, height: screenHeight * 0.035)
                                   .opacity(darkenSemiUrgent ? 0.5 : 1.0) // Darken by
                                   .onTapGesture {
                                       
                                       darkenSemiUrgent = true
                                       
                                       // Reset the darkening effect after a delay
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                           darkenSemiUrgent = false
                                       }
                                       
                                       selectedUrgencyIndex = 1
                                   }
                        
                        Rectangle()
                            .fill(nonUrgentColor)
                            .frame(width: screenWidth * 0.075, height: screenHeight * 0.035)
                                   .opacity(darkenNonUrgent ? 0.5 : 1.0) // Darken by
                                   .onTapGesture {
                                       
                                       darkenNonUrgent = true
                                       
                                      
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                           darkenNonUrgent = false
                                       }
                                       
                                       selectedUrgencyIndex = 2
                            }
                        
                        
                    }
                               
                    }
                    .padding()
         
            
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                    
                    let queuedItem = QueuedItem(title: itemTitle, description: itemDescription, urgencyIndex: selectedUrgencyIndex, durationIndex: selectedDurationIndex, containerWidth: 0.0, containerHeight: 0.0)
                    
                    
                    
                    
                       
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
