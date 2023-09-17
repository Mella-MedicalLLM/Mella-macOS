//
//  MainView.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/13.
//

import SwiftUI
import Combine
import AppKit

class MainViewModel: ObservableObject {
    let chatLogUseCase: ChatLogUseCase = AppContainer.shared.chatLogUseCase
    @Published var chatList: [ChatLog] = []
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchChatList() {
        chatLogUseCase.fetchChatLog()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: \.chatList, on: self)
            .store(in: &cancellable)
    }
    
    func deleteAllData() {
        chatLogUseCase.deleteAllChatLogs()
            .receive(on: DispatchQueue.main)
            .replaceError(with: false)
            .sink(receiveValue: { _ in
                self.fetchChatList()
            })
            .store(in: &cancellable)
    }
    
    func fetchSideBar(){
        chatLogUseCase.fetchChatLog()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .sink(receiveValue: { chatList in
                // self.chatList = chatList
            })
            .store(in: &cancellable)
    }
}


struct MainView: View {
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    var selectedChatId: String? = nil
    @State var inputText: String = ""
    @State var showNewDetailView: Bool = false
    @State var sendText: String? = nil
    
    var body: some View {
        NavigationSplitView {
            sideBar
                .background(Color.mellaWhite)
                .onAppear {
                    viewModel.fetchSideBar()
                }
        } detail: {
            NavigationStack{
                contentView
                    .navigationDestination(isPresented: $showNewDetailView) {
                        DetailView(chat: ChatLog(),
                                   firstMessage: sendText,
                                   fetchAction: {
                            viewModel.fetchSideBar()
                        })
                    }
            }
        }
        .onAppear {
            viewModel.fetchChatList()
        }
    }
    
    var sideBar: some View {
        VStack {
            List{
                Section(header: VStack{
                    Text("Chat List")
                        .font(.pretendard(size: 16))
                        .padding(20)
                }) {
                    ForEach(viewModel.chatList, id: \.id) { chat in
                        NavigationLink(destination: {
                            DetailView(chat: chat,
                                       fetchAction: {
                                viewModel.fetchSideBar()
                            })
                        }) {
                            VStack(alignment: .leading){
                                Text("\(chat.logs.first?.message ?? "Chat")")
                                    .font(.pretendard(size: 18))
                                    .lineLimit(1)
                                    .multilineTextAlignment(.leading)
                                Text("\(chat.lastSendTime)")
                                    .multilineTextAlignment(.leading)
                                
                            }
                            .padding()
                        }
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
            }
            .listStyle(.sidebar)
            VStack{
                Group{
                    Button{
                        viewModel.fetchChatList()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Refresh")
                            Spacer()
                        }
                    }
                    
                    Button{
                        viewModel.deleteAllData()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Remove All")
                            Spacer()
                        }
                    }
                } .buttonStyle(.plain)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(16)
                
            }
            .padding()
        }
    }
    
    var introView: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                HStack (alignment: .center){
                    Text("MELLA")
                        .font(.pretendard(size: 48, weight: .bold))
                        .frame(height: 52)
                    Image("mella")
                        .resizable()
                        .frame(width: 52, height: 52)
                        .cornerRadius(16)
                        .padding(.leading, 4)
                }
                .padding(.vertical)
                VStack(alignment:.leading) {
                    Text("LLM for Healthcare Questions")
                        .font(.pretendard(size: 24))
                        .foregroundColor(.black.opacity(0.3))
                        .padding(.bottom, 2)
                    
                    Text("Fine-tuned By HAI LAB.")
                        .font(.pretendard(size: 16))
                        .foregroundColor(.black.opacity(0.3))
                }
                
            }
        }
    }
    
    var contentView: some View {
        VStack {
            ScrollView(showsIndicators:false) {
                VStack(alignment: .leading) {
                    Spacer()
                    introView
                    Spacer()
                    HStack { Spacer() }
                }
                .padding(140)
            }
            ChatSenderView(inputText: $inputText){
                self.sendText = inputText
                self.showNewDetailView.toggle()
            }
        }
        .background(Color.mellaWhite)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
