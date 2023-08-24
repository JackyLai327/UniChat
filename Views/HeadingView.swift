//
//  HeadingView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import SwiftUI

struct HeadingView: View {
    
    var title: String
    
    var body: some View {
        VStack (spacing: 0) {
            if title == "" {
                HStack {}
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
            } else {
                Text(title)
                    .font(.title.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
            }
            Divider()
                .overlay(UniChatColor.brown)
        }
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingView(title: "Title")
    }
}
