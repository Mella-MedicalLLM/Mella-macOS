//
//  DetailView.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/13.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    let chatLogUseCase: ChatLogUseCase = AppContainer.shared.chatLogUseCase
    
    @Published var chat: ChatLog? = nil
    @Published var isLoading: Bool = false
    @Published var messageLists: [ChatMessage] = []
    var fetchAction: (() -> Void)?
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    var testToggle: Bool = false
    
    func createFirstChat(firstMessage: String) {
        guard let chat = chat else { return }
        print("create")
        chatLogUseCase.createChatLog(chatLog: chat)
            .map { _ in true }
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)
            .sink { result in
                self.sendMessage(firstMessage)
            }
            .store(in: &cancellable)
    }
    
    func sendMessage(_ inputText: String) {
        guard let chat = chat else { return }
        let newMessage = ChatMessage(chatLogId: chat.id,
                                  message: inputText,
                                  sender: testToggle ? .mella : .user)
        chatLogUseCase.createChatMessage(chatMessage: newMessage)
            .map { _ in true }
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)
            .sink { result in
                print("sendMessage:", result)
                self.fetchMessage()
            }
            .store(in: &cancellable)
    }
    
    func fetchMessage() {
        guard let chat = chat else { return }
        chatLogUseCase.fetchChatMessages(chatLogId: chat.id)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { messageLists in
                print("messageLists:", messageLists)
                self.messageLists = messageLists
                self.fetchAction?()
            }
            .store(in: &cancellable)
    }
}

struct DetailView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var viewModel = DetailViewModel()
    
    @State var inputText: String = ""
   
    
    init(chat: ChatLog,
         firstMessage: String? = nil,
         fetchAction: (() -> Void)?) {
        self.viewModel.chat = chat
        self.viewModel.fetchAction = fetchAction
        if let firstMessage = firstMessage,
            firstMessage != "" {
            self.viewModel.createFirstChat(firstMessage: firstMessage)
        } else {
            self.viewModel.fetchMessage()
        }
    }
    
    var body: some View {
        VStack {
            chatView
            HStack { Spacer() }
            ChatSenderView(inputText: $inputText,
                           isLoading: $viewModel.isLoading) {
                viewModel.sendMessage(inputText)
            }
        }
        .background(Color.mellaWhite)
    }
    
    var chatView: some View {
        ScrollView (showsIndicators:false) {
            LazyVStack {
                HStack{
                    VStack(alignment:.leading) {
                        Text("\(viewModel.chat?.logs.first?.message ?? "Chat")")
                        .font(.pretendard(size: 18))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        Text("\((viewModel.chat?.lastSendTime ?? Date()).dateToString())")
                        .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.pretendard(size: 24))
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .background(Color.mellaLightGray.opacity(0.4))
                VStack {
                    ForEach(viewModel.messageLists,
                            id: \.messageId) { message in
                        MessageView(message)
                    }
                }
            }
        }
    }
}
