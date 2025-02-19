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
    
    @Environment(\.colorScheme) var colorScheme
    let gridColumns = [GridItem(), GridItem(), GridItem()]
    var body: some View {
        VStack{
            
            // image and name
            info
            
            // filters
            filters
            
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
                .frame(width: 100, height: 100)
            
            Text("xinxinxin_chen")
                .font(.title)
            
        }
    }
    
    var filters : some View {
        VStack{
            
            ScrollView (.horizontal) {
                HStack{
                    ForEach(ReferenceObjectSource.allCases, id: \.self) { source in
                        Button {
                            profileViewModel.selectedSource = source
                        } label: {
                            FilterCard(title: source.toUIString)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .scrollIndicators(.hidden)
            }
            
            ScrollView (.horizontal) {
                HStack{
                    ForEach(ReferenceObjectDimensionFilters.allCases, id: \.self) { dimensionFilter in
                        Button {
                            profileViewModel.selectedDimesion = dimensionFilter
                        } label: {
                            FilterCard(title: dimensionFilter.toUIString)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    var gridOfReferences : some View {
        ScrollView{
            LazyVGrid(columns: gridColumns) {
                ForEach(referencesViewModel.listOfReferences) { reference in
                    if ((profileViewModel.selectedDimesion.filterByDimension(inputDimension: reference.numberOfDimensions)) && (reference.source == profileViewModel.selectedSource)) {
                        ReferenceObjectCard(referenceObject: reference)
                    }
                }
            }
        }
    }
}

struct FilterCard : View {
    @Environment(\.colorScheme) var colorScheme
    var title : String
    var body: some View {
        VStack {
            Text(title)
                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                .font(.headline)
        }
        .padding(20)
        .background(Color.primary)
        .padding(2)
        .background(Color.primary.colorInvert())
    }
}

#Preview {
    Profile()
}
