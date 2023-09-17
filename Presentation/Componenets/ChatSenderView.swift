//
//  ChatSenderView.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/13.
//

import SwiftUI

struct ChatSenderView: View {
    @Binding private var inputText: String
    @FocusState private var isFocused: Bool
    @Binding var isLoading: Bool
    private var sendAction: ()->Void
    
    
    init(inputText: Binding<String>,
         isLoading: Binding<Bool>? = nil,
         sendAction: @escaping ()->Void) {
        self._inputText = inputText
        self._isLoading = isLoading ?? Binding.constant(false)
        self.sendAction = sendAction
    }
    
    var body: some View {
        VStack{
        HStack {
            Spacer()
            HStack{
                TextField("Feel free to talk to me.", text: $inputText)
                    .font(.pretendard(size: 18))
                    .lineLimit(4)
                    .textFieldStyle(.plain)
                    .padding(.vertical)
                    .focused($isFocused)
                Divider()
                    .frame(height: 22)
                Button {
                    action()
                } label: {
                    if isLoading {
                       
                    } else if inputText != "" {
                        Image.sendImage
                            .resizable()
                    } else {
                        Image.sendImage
                            .resizable()
                    }
                }
                .buttonStyle(.plain)
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
                .padding(.leading)
                
            }
            .onSubmit {
                action()
            }
            .padding(.horizontal, 26)
            .background(isFocused ? Color.mellaWhite : Color.mellaLightGray)
            .cornerRadius(26)
            .overlay(
                RoundedRectangle(cornerRadius: 26)
                    .stroke(isFocused ? LinearGradient.mellaGradient() : LinearGradient.mellaGradient([.clear]),
                            lineWidth: 2)
            )
            Spacer()
            
        }
            Text("mella can provide inaccurate or offensive information.")
                .font(.pretendard(size: 14))
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 6)
        }
        .padding(.horizontal, 100)
        .padding(.bottom, 40)
    }
    
    func action() {
        guard inputText != "" else { return }
        sendAction()
        self.inputText = ""
    }
}
