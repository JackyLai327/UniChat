//
//  HeadingView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import SwiftUI

/// The heading for each page
struct HeadingView: View {
    
    // displayed at the top
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
                    .font(.title2.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(UniChatColor.headerYellow)
                    .foregroundColor(UniChatColor.brown)
            }
            Divider()
        }
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingView(title: "Title")
    }
}
