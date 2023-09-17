//
//  DefaultChatLogUseCase.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation
import Combine

final class DefaultChatLogUseCase {
    private var chatLogRepository: ChatLogRepository
    
    init(chatLogRepository: ChatLogRepository) {
        self.chatLogRepository = chatLogRepository
    }
}

extension DefaultChatLogUseCase: ChatLogUseCase {
    func createChatLog(chatLog: ChatLog) -> AnyPublisher<ChatLog, Error> {
        chatLogRepository.createChatLog(chatLog: chatLog)
    }
    
    func createChatMessage(chatMessage: ChatMessage) -> AnyPublisher<ChatMessage, Error> {
        chatLogRepository.createChatMessage(chatMessage: chatMessage)
    }
    
    func fetchChatLog() -> AnyPublisher<[ChatLog], Error> {
        chatLogRepository.fetchChatLog()
    }
    
    func fetchChatMessages(chatLogId: String) -> AnyPublisher<[ChatMessage], Error> {
        self.chatLogRepository.fetchChatMessages(chatLogId: chatLogId)
    }
    
    func deleteChatLog(id: String) -> AnyPublisher<[ChatLog], Error> {
        self.chatLogRepository.deleteChatLog(id: id)
    }
    
    func deleteChatMessage(chatLogId: String) -> AnyPublisher<[ChatMessage], Error> {
        self.chatLogRepository.deleteChatMessage(chatLogId: chatLogId)
    }
    
    func deleteChatMessage(messageId: String) -> AnyPublisher<[ChatMessage], Error> {
        self.chatLogRepository.deleteChatMessage(messageId: messageId)
    }
    
    func deleteAllChatLogs() -> AnyPublisher<Bool, Error> {
        self.chatLogRepository.deleteAllChatLogs()
    }
}
