//
//  Share.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct Share: View {
    var body: some View {
        VStack{
            HStack{
                Text("Xin Chen's Art")
                Image(systemName: "chchevron.down")
            }
            
            Image(.art)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    Share()
}
