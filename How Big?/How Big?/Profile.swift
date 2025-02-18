//
//  Profile.swift
//  How Big?
//
//  Created by User on 18/02/2025.
//

import SwiftUI

struct Profile: View {
    @StateObject var profileViewModel = ProfileViewModel.shared
    @StateObject var referencesViewModel = ReferencesViewModel.shared
    
    let gridColumns = [GridItem(), GridItem(), GridItem(), GridItem()]
    var body: some View {
        VStack{
            
            // image and name
            info
            
            
            // grid of references
            gridOfReferences
        }
    }
    
    var info : some View {
        HStack{
            Image(.art)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            
            Text("xinxinxin_chen")
                .font(.title)
            
        }
    }
    
    var gridOfReferences : some View {
        ScrollView{
            LazyVGrid(columns: gridColumns) {
                ForEach(referencesViewModel.listOfReferences) { reference in
                    ReferenceObjectCard(referenceObject: reference)
                        .environmentObject(referencesViewModel)
                    
                }
            }
        }
    }
}

#Preview {
    Profile()
}
