//
//  ContentView.swift
//  MPQ
//

import SwiftUI
import Foundation

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

func checkTimeUp(minutes: Double) -> Bool {
        let delayInSeconds = minutes * 60.0 // Convert minutes to seconds

        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            print("Time's up after \(minutes) minutes")
            // Perform any action here when the time is up
        }

        return true
    }




// struct repesenting element in queuw
struct QueuedItem {
    var title = ""
    var description = ""
    var urgencyIndex = 0
    var durationIndex = 0
    var alarm = 0
    var count = 0
    
    var containerWidth = 0.0
    var containerHeight = 0.0
    
    var backgroundColor = Color.red
    var tapped = false;
    
    var durations = ["1 min", "3 hours", "6 hours", "12 hours", "24 hours"]
    
    var times = [
        "1 min": 60,
        "3 hours": 180,
        "6 hours": 360,
        "12 hours": 720,
        "24 hours": 1440
    ]
    
    
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

        
    
//    func checkTimeUp(minutes: Double) -> Bool {
//        let delayInSeconds = minutes * 60.0 // Convert minutes to seconds
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
//            print("Time's up after \(minutes) minutes")
//            // Perform any action here when the time is up
//        }
//        
//        return true
//    }
//    
//    func checkUrgencyState() -> Int {
//        return urgencyIndex
//    }
    
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
    
    func display() -> some View {
        ZStack {
            Rectangle()
                .frame(width: CGFloat(containerWidth), height: CGFloat(containerHeight))
                .foregroundColor(backgroundColor)
                .cornerRadius(6.0)
            
            VStack {
    
                if(tapped) {
                    VStack {
                        StrokeText(text: title, width: 0.5, outerColor: .black, innerColor: Color(hex: 0xFCFCFC))
                            .font(.largeTitle)
                            .foregroundColor(Color(hex: 0xFCFCFC)) // Inner color
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(x: screenWidth * -0.05, y: screenHeight * 0.0075)
                            
                            .padding()


                        Rectangle()
                            .foregroundColor(Color.blue.opacity(0))
                            .frame(width: screenWidth, height: screenHeight * 0.01)
                            .alignmentGuide(.top) { _ in
                                  screenHeight * 0.25
                              }
//                            .offset(y: screenHeight * -0.1)
//                        Color(hex: 0xFCFCFC)
                       
                        ZStack {
                            Rectangle()
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.1)
                                .foregroundColor(Color(hex: 0xFCFCFC))
                                
                            
                            Text(description)
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(Color(hex: 0x000033))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: screenWidth * 0.8, minHeight: screenHeight * 0.045, alignment: .leading)
                                .offset(x: screenWidth * -0.025, y: screenHeight * -0.025)
                                .lineLimit(5) // Allow text to display multiple lines
                            .padding(.leading)
                        }.offset(y: screenHeight * -0.025)
                        
                          
                    }.frame(maxWidth: screenWidth * 0.8)
                } else {
                    
                    StrokeText(text: title, width: 0.5, outerColor: .black, innerColor: Color(hex: 0xFCFCFC))
                        .font(.largeTitle)
//                        .system(size: 60)
                       
                        
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                
            }
            
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
    @State private var darkenUrgent = false
    @State private var darkenSemiUrgent = false
    @State private var darkenNonUrgent = false
    
    
    @State private var itemTitle = ""
    @State private var itemUrgency = ""
    @State private var itemDescription = ""
    
    @State private var queuedItem = QueuedItem()
    @State private var queuedItems: [QueuedItem] = []
    
    @State private var selectedDurationIndex = 0
    @State private var selectedUrgencyIndex = 0
   
    
    let urgencies = ["Urgent", "Semi-urgent", "Non-urgent"]
    let durations = ["1 min", "3 hours", "6 hours", "12 hours", "24 hours"]
    @State var alarm = 0
    
    var times = [
        "1 min": 60,
        "3 hours": 180,
        "6 hours": 360,
        "12 hours": 720,
        "24 hours": 1440
    ]
    
    func startItemUpdateTimer() {
            print("timer starting")
            // Update the queued items here
            for index in queuedItems.indices {
                print("looping")
                switch queuedItems[index].urgencyIndex {
                case 0:
                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]! / 3)), repeats: false) { _ in
                        queuedItems[index].urgencyIndex = 1
                    }
                    // Store the timer in case you need to invalidate it later
                    // You might want to store the timers in an array if needed
                case 1:
                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]! / 2)), repeats: false) { _ in
                        queuedItems[index].urgencyIndex = 2
                    }
                case 2:
                    print("checking green")
                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval((times[durations[queuedItems[index].durationIndex]]!)), repeats: false) { _ in
                        print("Done!")
                    }
                default:
                    break
                }
                // Store the timers if needed
            }
        }
    
    // User View
    var body: some View {
        
            ZStack {
//                Image("Logo2").resizable()
//                    .frame(width: screenWidth, height: screenHeight * 0.2)
//                    .offset(y: screenHeight * -0.3)
//                
                
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
                            
                          
                            
                            queuedItems[index].display()
                                .onAppear {
                                    queuedItems[index].containerWidth = screenWidth * 0.99
                                    queuedItems[index].containerHeight = screenHeight * 0.1
                                }
                                .onTapGesture {
                                    if modalActive {
                                        queuedItems[index].containerWidth = screenWidth * 0.96
                                        queuedItems[index].containerHeight = screenHeight * 0.2
                                        modalActive = false
                                        queuedItems[index].tapped = true
                                    } else {
                                        queuedItems[index].containerWidth = screenWidth * 0.99
                                        queuedItems[index].containerHeight = screenHeight * 0.1
                                        modalActive = true
                                        queuedItems[index].tapped = false
                                    }
                                }
                        }
                    }
                    .onAppear {
                        
                        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(10), repeats: true) { _ in
                                       startItemUpdateTimer()
                                   }
                        
//                        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(10, repeats: false) { _ in
//
//                        })
                    }
                    
                    Spacer()
                        
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
                    
                    var queuedItem = QueuedItem(title: itemTitle, description: itemDescription, urgencyIndex: selectedUrgencyIndex, durationIndex: selectedDurationIndex)
                    //queuedItem.prioritize()

                    switch selectedUrgencyIndex {
                        case 0:
                            queuedItem.backgroundColor = urgentColor
                        case 1:
                          
                            queuedItem.backgroundColor = semiUrgentColor
                        case 2:
                            
                            queuedItem.backgroundColor = nonUrgentColor
                        default:
                            break
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
