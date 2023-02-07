//
//  MovieDetailView.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var detailViewModel: MovieDetailViewModel
    let imagePath = "xmark"
    var body: some View {
        VStack(spacing: 10) {
            let posterImageView: Image = Image(systemName: imagePath)
                .resizable()
                
            posterImageView
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                .cornerRadius(5)
            if detailViewModel.isImageHidden {
                posterImageView.hidden()
            }
            Text(detailViewModel.information)
                .lineLimit(nil)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            Spacer()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(detailViewModel: .createDummy())
    }
}
