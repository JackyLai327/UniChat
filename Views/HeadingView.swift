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
            Text(title)
                .font(.title.bold())
                .padding()
                .frame(maxWidth: .infinity)
                .background(UniChatColor.headerYellow)
                .foregroundColor(UniChatColor.brown)
            Divider()
                .frame(width: .infinity, height: 1)
                .overlay(UniChatColor.brown)
        }
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingView(title: "Title")
    }
}
