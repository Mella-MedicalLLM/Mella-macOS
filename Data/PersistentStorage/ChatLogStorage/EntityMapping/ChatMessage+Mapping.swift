//
//  ChatMessage+Mapping.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation
import CoreData
import CoreDataStorage

extension ChatMessageEntity: Objectable {
    public func toObject() -> some Entitable {
        ChatMessage(chatLogId: chatLogId ?? "",
                    messageId: messageId ?? "",
                    sender: ChatSender(rawValue: sender ?? ChatSender.unknown.rawValue) ?? .unknown,
                    message: message ?? "",
                    sendTime: sendTime ?? Date())
    }
}


extension ChatMessage: Entitable {
    func toEntity(in context: NSManagedObjectContext) -> ChatMessageEntity {
        let entity: ChatMessageEntity = .init(context: context)
        entity.chatLogId = chatLogId
        entity.messageId = messageId
        entity.sender = sender.rawValue
        entity.message = message
        entity.sendTime = sendTime
        return entity
    }
}

