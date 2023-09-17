//
//  ChatLog+Mapping.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation
import CoreData
import CoreDataStorage


extension ChatLogEntity: Objectable {
    public func toObject() -> some Entitable {
        ChatLog(id: id ?? "-",
                lastSendTime: lastSendTime ?? Date(),
                logs: [])
    }
}


extension ChatLog: Entitable {
    func toEntity(in context: NSManagedObjectContext) -> ChatLogEntity {
        let entity: ChatLogEntity = .init(context: context)
        entity.id = id
        entity.lastSendTime = lastSendTime
        return entity
    }
}

