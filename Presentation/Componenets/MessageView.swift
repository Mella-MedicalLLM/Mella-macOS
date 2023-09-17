//
//  MessageView.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import SwiftUI

struct MessageView: View {
    private var chatMessage: ChatMessage
    
    init(_ chatMessage: ChatMessage){
        self.chatMessage = chatMessage
    }
    
    var body: some View {
        VStack{
            
            if chatMessage.sender == .mella {
                mellaMessageView
                    .padding(.vertical)
            } else {
                userMessageView
                    .padding(.vertical)
            }
            Divider()
                .overlay(LinearGradient.mellaGradient())
                .padding(.horizontal, 100)
        }
    }
    
    var mellaMessageView: some View {
        HStack (alignment: .top) {
            Image("mella")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(16)
            VStack (alignment: .leading) {
                Text(chatMessage.message)
                    .multilineTextAlignment(.leading)
                    .font(.pretendard(size: 16))
                    .lineSpacing(20)
                HStack{ Spacer() }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .padding(.horizontal, 120)
    }
    
    var userMessageView: some View {
        HStack (alignment: .top) {
            VStack (alignment: .leading) {
                Text(chatMessage.message)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .font(.pretendard(size: 22, weight: .bold))
                    .lineSpacing(14)
                HStack{ Spacer() }
            }
        }
        .clipped(antialiased: false)
        .padding(.horizontal, 120)
    }
}
