//
//  CardDetailView.swift
//  WalletAppAnimation
//
//  Created by Zelyna Sillas on 11/14/23.
//

import SwiftUI

struct CardDetailView: View {
    var detailHeader: String
    var balance: String
    var bgColor: Color
    @State private var allExpenses: [Expense] = []
    @Environment(\.colorScheme) var scheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .padding(.leading, 18)
                            .onTapGesture {
                                dismiss()
                            }
                        
                        Text(detailHeader)
                            .font(.largeTitle).bold()
                    }
                    .frame(height: 45)
                    
                    HeaderCardView()
                        .containerRelativeFrame(.horizontal)
                        .frame(height: 125)
                }
                
                LazyVStack(spacing: 15) {
                    Menu {
                    } label: {
                        HStack(spacing: 4) {
                            Text("Filter By")
                            Image(systemName: "chevron.down")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    ForEach(allExpenses) { expense in
                        ExpenseCard(expense)
                    }
                }
                .padding(15)
                .mask {
                    Rectangle()
                        .visualEffect { content, proxy in
                            content
                                .offset(y: backgroundLimitOffset(proxy))
                        }
                }
                .background {
                    GeometryReader {
                        let rect = $0.frame(in: .scrollView)
                        let minY = min(rect.minY - 125, 0)
                        let progress = max(min(-minY / 25, 1), 0)
                        
                        RoundedRectangle(cornerRadius: 30 * progress, style: .continuous)
                            .fill(scheme == .dark ? .black : .white)
                        //limiting background scroll below header card
                            .visualEffect { content, proxy in
                                content
                                    .offset(y: backgroundLimitOffset(proxy))
                            }
                    }
                }
            }
            .padding(.vertical, 15)
        }
        .scrollTargetBehavior(CustomScrollBehaviour())
        .scrollIndicators(.hidden)
        .onAppear {
            allExpenses = expenses.shuffled()
        }
        .navigationBarBackButtonHidden()
    }
    
    func backgroundLimitOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        
        return minY < 100 ? -minY + 100 : 0
    }
    
    @ViewBuilder
    func HeaderCardView() -> some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            let minY = rect.minY
            let topValue: CGFloat = 75.0
            
            let offset = min(minY - topValue, 0)
            let progress = max(min(-offset / topValue, 1), 0)
            let scale: CGFloat = 1 + progress
            
            ZStack {
                Rectangle()
                    .fill(bgColor)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(bgColor)
                            .overlay {
                                Circle()
                                    .fill(.white.opacity(0.2))
                            }
                            .scaleEffect(2, anchor: .topLeading)
                            .offset(x: -50, y: -40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .scaleEffect(scale, anchor: .bottom)
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer(minLength: 0)
                    
                    Text("Current Balance")
                        .font(.callout)
                    
                    Text(balance)
                        .font(.title).bold()
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
                .offset(y: progress * -25)
            }
            .offset(y: -offset)
            .offset(y: progress * -topValue)
        }
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func ExpenseCard(_ expense: Expense) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.product)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer(minLength: 0)
            
            Text(expense.amountSpent).bold()
            
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 6)
    }
}

//scrollWithEndDragging from UIKit
struct CustomScrollBehaviour: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 75 {
            target.rect = .zero
        }
    }
}


#Preview {
    CardDetailView(detailHeader: "Apple Card", balance: "$145.00", bgColor: .blue)
}
