//
//  ChatLogRepository.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation
import Combine

protocol ChatLogRepository {
    func createChatLog(chatLog: ChatLog) -> AnyPublisher<ChatLog, Error>
    func createChatMessage(chatMessage: ChatMessage) -> AnyPublisher<ChatMessage, Error>
    func fetchChatLog() -> AnyPublisher<[ChatLog], Error>
    func fetchChatMessages(chatLogId: String) -> AnyPublisher<[ChatMessage], Error>
    func deleteChatLog(id: String) -> AnyPublisher<[ChatLog], Error>
    func deleteChatMessage(chatLogId: String) -> AnyPublisher<[ChatMessage], Error>
    func deleteChatMessage(messageId: String) -> AnyPublisher<[ChatMessage], Error>
    func deleteAllChatLogs() -> AnyPublisher<Bool, Error>
}
