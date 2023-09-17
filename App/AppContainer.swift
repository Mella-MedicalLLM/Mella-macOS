//
//  AppContainer.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation

final class AppContainer {
    static let shared: AppContainer = AppContainer()
    private init() { }

    lazy var chatLogStorage: ChatLogStorage = CoreDataChatLogSotrage()
    lazy var chatLogRepository: ChatLogRepository = DefaultChatLogRepository(chatLogStorage: chatLogStorage)
    lazy var chatLogUseCase: ChatLogUseCase = DefaultChatLogUseCase(chatLogRepository: chatLogRepository)
    
}
