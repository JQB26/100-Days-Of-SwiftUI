//
//  ContentView.swift
//  06-Animations
//
//  Created by Jakub Szczepanek on 08/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount1 = 0.0
    @State private var animationAmount2 = 0.0
    @State private var animationAmount3 = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            
            Button("Tap Me") {
                // animationAmount1 += 1
            }
            .padding(50)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.blue)
                    .scaleEffect(animationAmount1)
                    .opacity(2 - animationAmount1)
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationAmount1
                    )
            )
            .onAppear {
                animationAmount1 = 2
            }
            
            Spacer()
            
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    animationAmount2 += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount2), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
            
            VStack {
                Divider()
                Stepper("Scale amount", value: $animationAmount3.animation(
                    .easeOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
                ), in: 0.5...1.5, step: 0.5)
                    .padding()
                    
                
                Button("Tap Me") {
                    animationAmount3 += 1
                }
                .padding(40)
                .background(.green)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount3)
            }
            
            Spacer()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
