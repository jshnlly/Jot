//
//  ContentView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI
import UserNotifications
import CoreHaptics

struct ContentView: View {
    
    @AppStorage("darkMode") private var darkMode = false
    var onboardingShown: Bool = false
    @ObservedObject var userSettings = UserSettings()
    @State private var engine: CHHapticEngine?
    @State var title = ""
    @State var note = "Jot something..."
    @State var clearPosition = false
    @State private var showArrow = false
    @State private var keyboardSize: CGFloat = 0
    @State var showSettings = false
    @State var titleView = true
    @State var frameSize = false
    @State var placeholderString = "Jot something..."
    @State private var sharing = false
    @State var showCopy = false
    @State var showingAbout = false
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    
//                    Creating the scrollable text area
                    
                    ScrollView {
                        VStack {
                            VStack {
                                TextField("Add a title",text: $title)
                                    .padding(.leading, 16)
                                    .padding(.top, 16)
                                    .font(.system(size: 24, weight: .semibold))
                                    .opacity(userSettings.titleView ? 1 : 0)
                                
                                TextEditor(text: $note)
                                    .padding(.leading, 12)
                                    .padding(.top, 12)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(note != placeholderString ? .textColor : .placeholder)
                                    .frame(height: frameSize ? 750 : 300 )
                                    .onTapGesture {
                                                if note == placeholderString {
                                                  self.note = ""
                                                }
                                              }
                            }
                        }
                    }
                    .padding(.top, 32)
                    
//                    Button & main navigation actions
                    
                    HStack(spacing: 12){
                        Button(action: {
                            if showArrow {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                                prepareHaptics()
                                complexSuccess()
                            }
                        }, label: {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.brand)
                                .frame(width: 60, height: 48)
                                .background(Color.accent)
                                .cornerRadius(8)
                                .opacity(showArrow ? 1 : 0)
                                .animation(.easeInOut)
                        })
                        .disabled(clearPosition == true)
                        
                        Button(action: {
                            
                            showSettings.toggle()
                            prepareHaptics()
                            complexSuccess()
                        }, label: {
                            Image(systemName: "gear")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.brand)
                                .frame(width: 60, height: 48)
                                .background(Color.accent)
                                .cornerRadius(8)
                                .opacity(showArrow ? 0 : 1)
                                .animation(.easeInOut)
                        })
                        .disabled(clearPosition == true)
                        
                        Button(action: {
                            UIPasteboard.general.string = note
                            let av = UIActivityViewController(activityItems: [ UIPasteboard.general.string ?? "no data"], applicationActivities: nil)
                            
                            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                            
                            prepareHaptics()
                            complexSuccess()
                        }, label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.brand)
                                .frame(width: 60, height: 48)
                                .background(Color.accent)
                                .cornerRadius(8)
                                .opacity(1)
                        })
                        .disabled(clearPosition == true)
                        
                        Button(action: {
                            withAnimation {
                                showCopy.toggle()
                            }
                            UIPasteboard.general.string = note
                            
                            simpleSuccess()
                        }, label: {
                            HStack {
                                Image(systemName: "doc.on.doc")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.brand)
                            }
                            .padding(4)
                            .frame(width: 60, height: 48)
                            .background(Color.accent)
                            .cornerRadius(8)
                        })
                        .disabled(clearPosition == true)
                        
                        Button(action: {
                            if note.count > 20 || title.count != 0  {
                                clearPosition.toggle()
                                
                                prepareHaptics()
                                complexSuccess()
                            } else {
                             note = "Jot something..."
                                simpleSuccess()
                            }
                            
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                           
                        }, label: {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.brand)
                            }
                            .frame(width: 60, height: 48)
                            .background(Color.accent)
                            .cornerRadius(8)
                            
                        })
                        .disabled(clearPosition == true)
                    }
                    .padding(16)
                    .padding(.bottom, 24)
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                            return
                        }
                        showArrow = true
                        self.keyboardSize = keyboardFrame.height
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                        
                        frameSize = true
                        showArrow.toggle()
                    }
                }
                .animation(.easeInOut)
                
//                Bg rectangle & shader
                
                Rectangle()
                    .foregroundColor(.overlay)
                    .opacity(clearPosition || showSettings || showCopy ? 0.6 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut)
                    .onTapGesture {
                        if showSettings || showCopy {
                        showSettings = false
                        showCopy = false
                        }
                    }
                
//                    Clear view
                
                    VStack {
                        VStack {
                            Text("Are you sure you want to clear?")
                                .font(.system(size: 20, weight: .medium))
                                .padding(4)
                            Text("This cannot be undone.")
                                .foregroundColor(Color(#colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 1)))
                            Button(action: {
                                title = ""
                                note = "Jot something..."
                                clearPosition.toggle()
                            }, label: {
                                Text("Clear Note")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(.error)
                                    .frame(width: screen.width - 64, height: 44)
                                    .background(Color.accent)
                                    .cornerRadius(8)
                            })
                            .padding(.bottom, 8)
                            .padding(.top, 8)

                            Button(action: {
                                clearPosition.toggle()
                            }, label: {
                                Text("Cancel")
                                    .font(.system(size: 18, weight: .regular))
                                    .frame(width: screen.width - 64, height: 44)
                                    .foregroundColor(.brand)
                                    .background(Color.accent)
                                    .cornerRadius(8)
                            })
                        }
                        .padding()
                        .frame(width: screen.width - 32, height: 220, alignment: .center)
                        .background(Color.sheet)
                        .cornerRadius(10)
                        .offset(y: clearPosition ? 8 : -300)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7))
                        
                        Spacer()
                        
//                      Settings View
                        
                        VStack {
                            Spacer()
                            VStack {
                                VStack {
                                    HStack {
                                        Image(systemName: "doc.text")
                                            .padding(.trailing, 8)
                                            .font(.system(size: 22, weight: .medium))
                                            .foregroundColor(.brand)
                                        Toggle(isOn: $userSettings.titleView) {
                                            Text("Start Notes with Title")
                                        }
                                        .toggleStyle(SwitchToggleStyle(tint: .brand))

                                    }
                                    .padding(.leading, 12)
                                    .padding(.trailing, 12)
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                    .background(Color.accent)
                                    .cornerRadius(8)
                                    
                                    HStack {
                                        Image(systemName: "moon")
                                            .padding(.trailing, 8)
                                            .font(.system(size: 22, weight: .medium)).foregroundColor(.brand)
                                            .animation(.spring(response: 0.3, dampingFraction: 0.7))
                                        Toggle(isOn: $darkMode){
                                            Text("Dark Mode")
                                        }
                                        .foregroundColor(.textColor)
                                        .toggleStyle(SwitchToggleStyle(tint: .brand))
                                    }
                                    .padding(.leading, 12)
                                    .padding(.trailing, 12)
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                    .background(Color.accent)
                                    .cornerRadius(10)
                                    
                                    Button(action: {
                                        showingAbout.toggle()
                                    }, label: {
                                        HStack {
                                            Image(systemName: "info.circle")
                                                .padding(.trailing, 8)
                                                .font(.system(size: 22, weight: .medium))
                                                .foregroundColor(.brand)

                                            Text("About Jottie")
                                                .foregroundColor(.textColor)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.leading, 12)
                                        .padding(.trailing, 12)
                                        .padding(.top, 8)
                                        .padding(.bottom, 8)
                                        .background(Color.accent)
                                        .cornerRadius(8)
                                        .foregroundColor(.textColor)
                                    })
                                    .sheet(isPresented: $showingAbout, content: {
                                        AboutView(aboutPresented: $showingAbout)
                                            .preferredColorScheme(darkMode ? .dark : .light)
                                    })
                                    
                                }
                                .padding()
                            }
                            .background(Color.sheet)
                            .cornerRadius(10)
                            .padding()
                        }
                            .offset(y: showSettings ? 0 : 450)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7))
                        
                }
                
//                Copy View
                
                CopyAlertView()
                    .offset(y: showCopy ? 0 : -200)
                    .opacity(showCopy ? 1 : 0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7))
                
            }
        }
    }
    
//    Haptic support
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

//preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//color groupings -> lets use colors across app

extension Color {
    static let placeholder = Color("placeholder")
    static let brand = Color("brand")
    static let error = Color("error")
    static let sheet = Color("sheet")
    static let accent = Color("accent")
    static let overlay = Color("overlay")
    static let textColor = Color("textColor")
    static let bg = Color("bg")
}

//screen dimensions -> lets make sizes the width of the screen flexible 

let screen = UIScreen.main.bounds


