//
//  NetworkUserMessage.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 19/10/26.
//

import UIKit

extension MessageViewController {
    func setupNetworkCalls() {
        messages = [
            ChatMessage(text: "Привет брат.", isFromCurrentUser: false),
            ChatMessage(text: "Привет.", isFromCurrentUser: true),
            ChatMessage(text: "Сколько, по-твоему, стоит?", isFromCurrentUser: false),
        ]
        
        rootView.setupMessages(messages: messages)
    }
}
