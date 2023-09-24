//
//  ProfileDetailsView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/19.
//

import SwiftUI

struct ProfileDetailsView: View {
    
    var profileID: String = ""
    
    var body: some View {
        Text(profileID)
    }
}

struct ProfileDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailsView()
    }
}
