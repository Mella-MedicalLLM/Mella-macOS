//
//  DefaultChatLogRepository.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation
import Combine

final class DefaultChatLogRepository {
    private var chatLogStorage: ChatLogStorage
    
    init(chatLogStorage: ChatLogStorage) {
        self.chatLogStorage = chatLogStorage
    }
}

extension DefaultChatLogRepository: ChatLogRepository {
    func createChatLog(chatLog: ChatLog) -> AnyPublisher<ChatLog, Error> {
        chatLogStorage.createChatLog(chatLog: chatLog)
    }
    
    func createChatMessage(chatMessage: ChatMessage) -> AnyPublisher<ChatMessage, Error> {
        chatLogStorage.createChatMessage(chatMessage: chatMessage)
    }
    
    func fetchChatLog() -> AnyPublisher<[ChatLog], Error> {
        chatLogStorage.fetchChatLog()
            .eraseToAnyPublisher()
    }
    
    func fetchChatMessages(chatLogId: String) -> AnyPublisher<[ChatMessage], Error> {
        self.chatLogStorage.fetchChatMessages(chatLogId: chatLogId)
    }
    
    func deleteChatLog(id: String) -> AnyPublisher<[ChatLog], Error> {
        self.chatLogStorage.deleteChatLog(id: id)
    }
    
    func deleteChatMessage(chatLogId: String) -> AnyPublisher<[ChatMessage], Error> {
        self.chatLogStorage.deleteChatMessage(chatLogId: chatLogId)
    }
    
    func deleteChatMessage(messageId: String) -> AnyPublisher<[ChatMessage], Error> {
        self.chatLogStorage.deleteChatMessage(messageId: messageId)
    }
    func deleteAllChatLogs() -> AnyPublisher<Bool, Error> {
        self.chatLogStorage.deleteAllChatLogs()
            .flatMap { _ in
                self.chatLogStorage.deleteAllChatMessages()
            }
            .eraseToAnyPublisher()
    }
}
