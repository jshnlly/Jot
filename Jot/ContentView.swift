//
//  ContentView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI

struct ContentView: View {
    @State var title = ""
    @State var note = "Jot something..."
    @State var clearPosition = false
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack {
                        VStack {
                            TextField("Add a title",text: $title)
                                .padding(.leading, 16)
                                .padding(.top, 16)
                                .font(.system(size: 24, weight: .semibold))
                            
                            TextEditor(text: $note)
                                .padding(.leading, 12)
                                .padding(.top, 12)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.placeholder)
                                .frame(height: 300)
                        }
                    }
                }
                
                HStack(spacing: 12){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.brand)
                            .frame(width: 60, height: 48)
                            .background(Color.accent)
                            .cornerRadius(8)
                            .opacity(1)
                    })
                    .disabled(clearPosition == true)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "gear")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.brand)
                            .frame(width: 60, height: 48)
                            .background(Color.accent)
                            .cornerRadius(8)
                            .opacity(1)
                    })
                    .disabled(clearPosition == true)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
                        UIPasteboard.general.string = note
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
                        } else {
                         note = ""
                        }
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
            }
                
                VStack {
                    VStack {
                        Text("Are you sure you want to clear?")
                            .font(.system(size: 20, weight: .medium))
                            .padding(4)
                        Text("This cannot be undone.")
                            .foregroundColor(Color(#colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 1)))
                        Button(action: {
                            title = ""
                            note = ""
                            clearPosition.toggle()
                        }, label: {
                            Text("Clear Note")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.error)
                                .frame(width: 327, height: 44)
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
                                .frame(width: 327, height: 44)
                                .background(Color.accent)
                                .cornerRadius(8)
                        })
                    }
                    .padding()
                    .frame(width: 351, height: 220, alignment: .center)
                    .background(Color.sheet)
                    .cornerRadius(8)
                    .offset(y: clearPosition ? 0 : -300)
                    .animation(.easeInOut)
                    
                    Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let placeholder = Color("placeholder")
    static let brand = Color("brand")
    static let error = Color("error")
    static let sheet = Color("sheet")
    static let accent = Color("accent")
}
