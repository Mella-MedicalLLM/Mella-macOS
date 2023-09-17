//
//  CoreDataChatLogStorage.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import CoreData
import CoreDataStorage
import Combine

final class CoreDataChatLogSotrage {
    let persistentStorage = CoreDataStorage.shared(name: PersistentStorageNames.mellaDataStorage.name)
}

extension CoreDataChatLogSotrage: ChatLogStorage {
    
    func createChatLog(chatLog: ChatLog) -> AnyPublisher<ChatLog, Error> {
        persistentStorage.create(chatLog)
    }
    
    func createChatMessage(chatMessage: ChatMessage) -> AnyPublisher<ChatMessage, Error> {
        persistentStorage.create(chatMessage)
    }
    
    func fetchChatLog() -> AnyPublisher<[ChatLog], Error>  {
        persistentStorage.read(type: ChatLog.self,
                               sortDescriptors: [NSSortDescriptor(key: "lastSendTime",
                                                                  ascending: true)])
    }
    
    func fetchChatMessages(chatLogId: String) -> AnyPublisher<[ChatMessage], Error> {
        persistentStorage.read(type: ChatMessage.self,
                               predicate: NSPredicate(format: "chatLogId == %@", chatLogId),
                               sortDescriptors: [NSSortDescriptor(key: "sendTime",
                                                                  ascending: true)])
    }
    
    func deleteChatLog(id: String) -> AnyPublisher<[ChatLog], Error>  {
        persistentStorage.delete(ChatLog.self,
                                 predicate: NSPredicate(format: "id == %@", id))
        .flatMap { result in
            self.deleteChatMessage(chatLogId: id)
                .map{ _ in result}
        }
        .eraseToAnyPublisher()
    }
    
    func deleteChatMessage(chatLogId: String) -> AnyPublisher<[ChatMessage], Error> {
        persistentStorage.delete(ChatMessage.self,
                                 predicate: NSPredicate(format: "chatLogId == %@", chatLogId))
    }
    
    func deleteChatMessage(messageId: String) -> AnyPublisher<[ChatMessage], Error>  {
        persistentStorage.delete(ChatMessage.self,
                                 predicate: NSPredicate(format: "messageId == %@", messageId))
    }
    
    func deleteAllChatLogs() -> AnyPublisher<Bool, Error> {
        persistentStorage.deleteAll(ChatLog.self)
    }
    
    func deleteAllChatMessages() -> AnyPublisher<Bool, Error> {
        persistentStorage.deleteAll(ChatMessage.self)
    }
}
