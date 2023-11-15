//
//  ContentView.swift
//  WalletAppAnimation
//
//  Created by Zelyna Sillas on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var startAnimation: Bool = false
    @State var animateContent: Bool = false
    @State var animateText: [Bool] = [false, false]
    @State var backgroundWidth: CGFloat? = 0
    
    var body: some View {
        VStack(spacing: 15) {
            Header
                .padding(.bottom, 10)
            
            Card(logo: .apple, cardColor: .white, spent: "4178.50", cardNumer: "4322", cardIndex: 0)
                .zIndex(1)
            
            PaymentView()
                .zIndex(0)
            
            Card(logo: .mastercard, cardColor: .mastercardBlue, spent: "326.20", cardNumer: "5612", cardIndex: 1)
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Color(.black)
                .frame(width: backgroundWidth)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .ignoresSafeArea()
        }
        .onAppear {
            animateView()
        }
        .background {
            Color(.white)
                .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
    
    func animateView() {
        withAnimation(.easeInOut(duration: 0.4)) {
            backgroundWidth = 40
        }
        
        withAnimation(.interactiveSpring(response: 1.1, dampingFraction: 0.75, blendDuration: 0).delay(0.3)){
            backgroundWidth = nil
            startAnimation = true
        }
        
        // MARK: Enable Rolling Counters
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
            animateText[0] = true
            animateText[1] = true
        }
    }
    
    var Header: some View {
        HStack {
            Text("My Cards")
                .font(.title).bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(startAnimation ? 1 : 0)
                .offset(x: startAnimation ? 0 : 100)
                .animation(.interactiveSpring(response: 1, dampingFraction: 1, blendDuration: 1).delay(0.9), value: startAnimation)
            
            Button {
            } label: {
                Image(systemName: "plus")
                    .font(.title2).bold()
                    .foregroundStyle(.black)
                    .padding(10)
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.white)
                    }
            }
            .scaleEffect(startAnimation ? 1 : 0.001)
            .animation(.interactiveSpring(response: 1, dampingFraction: 0.6, blendDuration: 0.7).delay(0.7), value: startAnimation)
        }
    }
    
    @ViewBuilder
    func Card(logo: UIImage, cardColor: Color, spent: String, cardNumer: String, cardIndex: CGFloat)-> some View {
        let extraDelay: CGFloat = (cardIndex / 3.5)
        
        VStack(alignment: .leading, spacing: 15) {
            Image(uiImage: logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .offset(x: startAnimation ? 0 : 15, y: startAnimation ? 0 : 15)
                .opacity(startAnimation ? 1 : 0)
                .animation(.easeInOut(duration: 1).delay(1 + extraDelay), value: startAnimation)
            
            HStack(spacing: 4) {
                Text("$")
                    .font(.title).bold()
                
                let separatedString: [String] = spent.components(separatedBy: ".")
                if separatedString.indices.contains(0), animateText[0] {
                    RollingText(font: .title, weight: .bold, value: .constant(NSString(string: separatedString[0]).integerValue), animationDuration: 1.5)
                        .transition(.opacity)
                }
                
                Text(".")
                    .font(.title).bold()
                    .padding(.horizontal, -4)
                
                if separatedString.indices.contains(1), animateText[1] {
                    RollingText(font: .title, weight: .bold, value: .constant(NSString(string: separatedString[1]).integerValue), animationDuration: 1.5)
                        .transition(.opacity)
                }
            }
            .opacity(startAnimation ? 1 : 0)
            .animation(.easeInOut(duration: 1).delay(1.2 + extraDelay), value: startAnimation)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .trailing) {
                CVV()
                    .opacity(startAnimation ? 1 : 0)
                    .offset(x: startAnimation ? 0 : 70)
                    .animation(.interactiveSpring(response: 1, dampingFraction: 1, blendDuration: 1).delay(1.6), value: startAnimation)
            }
            
            Text("Balance")
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .opacity(startAnimation ? 1 : 0)
                .offset(y: startAnimation ? 0 : 70)
                .animation(.interactiveSpring(response: 1, dampingFraction: 1, blendDuration: 1).delay(1.5 + extraDelay), value: startAnimation)
            
            HStack {
                Text("**** **** ****")
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(3)
                
                Text(" " + cardNumer)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .offset(y: -6)
            }
            .opacity(startAnimation ? 1 : 0)
            .offset(y: startAnimation ? 0 : 70)
            .animation(.interactiveSpring(response: 1, dampingFraction: 1, blendDuration: 1).delay(1.6 + extraDelay), value: startAnimation)
        }
        .foregroundStyle(.black)
        .padding(15)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        // MARK: animating cards
        .rotation3DEffect(.init(degrees: startAnimation ? 0 : -70), axis: (x: 1, y: 0, z: 0), anchor: .center)
        .scaleEffect(startAnimation ? 1 : 0.001, anchor: .bottom)
        .animation(.interactiveSpring(response: 1, dampingFraction: 0.7, blendDuration: 1).delay(0.9 + extraDelay), value: startAnimation)
    }
    
    @ViewBuilder
    func CVV()-> some View {
        HStack(spacing: 5) {
            ForEach(1...3, id: \.self) { _ in
            Circle()
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.trailing, 8)
    }
    
    @ViewBuilder
    func PaymentView()-> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Date().formatted(date: .abbreviated, time: .omitted))
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
            
            Text("$705.50")
                .font(.title).bold()
                .foregroundStyle(.white)
                .offset(x: startAnimation ? 0 : 100)
                .opacity(startAnimation ? 1 : 0)
                .animation(.easeInOut(duration: 0.6).speed(0.7).delay(1.5), value: startAnimation)
            
            HStack {
                Button {
                } label: {
                    Text("Manage")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            Capsule()
                                .stroke(.white, lineWidth: 1)
                        }
                }
                
                Button {
                } label: {
                    Text("Pay Now")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            Capsule()
                                .fill(.white)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 12)
            .offset(y: startAnimation ? 0 : 100)
            .animation(.easeInOut(duration: 0.8).delay(1.8), value: startAnimation)
    
        }
        .overlay(alignment: .topTrailing) {
            Button {
            } label: {
                Text("Due")
                    .fontWeight(.semibold)
                    .foregroundStyle(.orange)
                    .underline(true, color: .orange)
            }
            .padding(15)
            .offset(x: startAnimation ? 0 : -100)
            .opacity(startAnimation ? 1 : 0)
            .animation(.easeInOut(duration: 0.8).speed(0.8).delay(1.7), value: startAnimation)
        }
        .padding(15)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.vertical, 10)
        // MARK: Animating Detail Card
        .rotation3DEffect(.init(degrees: startAnimation ? 0 : 30), axis: (x: 1, y: 0, z: 0))
        .offset(y: startAnimation ? 0 : -200)
        .opacity(startAnimation ? 1 : 0)
        .animation(.interactiveSpring(response: 1, dampingFraction: 0.9, blendDuration: 1).delay(1.2), value: startAnimation)
    }
    
    
}

#Preview {
    ContentView()
}
