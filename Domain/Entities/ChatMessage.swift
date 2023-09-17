//
//  ChatMessage.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation

struct ChatMessage {
    let chatLogId: String
    let messageId: String
    let sender: ChatSender
    let message: String
    let sendTime: Date
    
    init(chatLogId: String,
         messageId: String,
         sender: ChatSender,
         message: String,
         sendTime: Date) {
        self.chatLogId = chatLogId
        self.messageId = messageId
        self.sender = sender
        self.message = message
        self.sendTime = sendTime
    }
    
    init(chatLogId: String,
         message: String,
         sender: ChatSender) {
        self.chatLogId = chatLogId
        self.messageId = UUID().uuidString
        self.sender = sender
        self.message = message
        self.sendTime = Date()
    }
}
