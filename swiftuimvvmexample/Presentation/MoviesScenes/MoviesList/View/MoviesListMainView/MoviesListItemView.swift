//
//  MoviesListItemView.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/03.
//

import SwiftUI

struct MoviesListItemView: View {
    let itemData: MoviesListItemViewModel
    var title = "Title"
    var releaseDate = "Release Date"
    var overviewText = "Over View\nOver View\nOver View\nOver View\nOver View"
    var body: some View {
        HStack {
            VStack{
                Text(itemData.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 11, leading: 8, bottom: 0, trailing: 0))
                
                Text(itemData.releaseDate)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 3.5, leading: 8, bottom: 0, trailing: 0))
                
                Text(itemData.overview)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 6, leading: 8, bottom: 11, trailing: 0))
            }
            .frame(maxHeight: 140)
            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            Spacer()
            requestImage
                .resizable()
                .frame(width: 80, height: 100, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
    
    private var requestImage: Image {
        guard let path = itemData.posterImagePath else {
            return Image(systemName: "xmark")
        }
        return Image(systemName: "stopwatch")
    }
}

struct MoviesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            MoviesListItemView(itemData: .createDummy())
        }
    }
    
}
