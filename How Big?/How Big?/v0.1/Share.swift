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
                Image(systemName: "chevron.down")
            }
            
            Image(.art)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Don't look here")
        }
    }
}

#Preview {
    Share()
}
