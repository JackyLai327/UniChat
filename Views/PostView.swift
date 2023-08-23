//
//  PostView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/23.
//

import SwiftUI

struct PostView: View {
    
    var discussion: String
    
    var body: some View {
        Text("Post View of \(discussion)")
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(discussion: "preview")
    }
}
