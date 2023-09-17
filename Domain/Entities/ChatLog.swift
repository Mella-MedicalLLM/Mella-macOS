//
//  ChatLog.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation

struct ChatLog {
    let id: String
    let lastSendTime: Date
    let logs: [ChatMessage]
    
    init(id: String,
         lastSendTime: Date,
         logs: [ChatMessage]) {
        self.id = id
        self.lastSendTime = lastSendTime
        self.logs = logs
    }
    
    init(){
        self.id = UUID().uuidString
        self.lastSendTime = Date()
        self.logs = []
    }
}

extension ChatLog {
    func appendChatMessageString(_ messageString: String,
                                 sender: ChatSender) -> ChatLog {
        let newChatMessage = ChatMessage(chatLogId: id, message: messageString, sender: sender)
        let newLogs = (logs + [newChatMessage]).sorted { $0.sendTime > $1.sendTime }
        let lastSendTime = newLogs.last?.sendTime ?? Date()
        return ChatLog(id: id,
                       lastSendTime: lastSendTime,
                       logs: newLogs)
    }
    
    func appendChatMessages(_ messages: [ChatMessage]) -> ChatLog {
        let newLogs = (logs + messages).sorted { $0.sendTime > $1.sendTime }
        let lastSendTime = newLogs.last?.sendTime ?? Date()
        return ChatLog(id: id,
                       lastSendTime: lastSendTime,
                       logs: newLogs)
    }
}



