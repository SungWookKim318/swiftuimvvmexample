//
//  MoviesListMainView.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/03.
//

import SwiftUI

struct MoviesListMainView: View {
    @State var queryText: String = ""
    @State var selectedItem: MoviesListItemViewModel?
    @State var isShowDeatil: Bool = false
    @ObservedObject var moviesListViewModel: MoviesListViewModel
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(action: { [weak moviesListViewModel] text in
                    moviesListViewModel?.requestSearch(query: text)
                })
                ZStack {
                    MoviesListView(items: $moviesListViewModel.items, selectedItem: $selectedItem) { selectedItem in
                        self.moviesListViewModel.selectMovie(item: selectedItem)
                        self.isShowDeatil.toggle()
                    }
                    .clipped()
                    let progressView = ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray.opacity(0.5))
                    
                    if moviesListViewModel.loading == nil {
                        progressView.hidden()
                    } else {
                        progressView
                    }
                }
                if let detailView = moviesListViewModel.detailView {
                    NavigationLink(destination: detailView, isActive: $isShowDeatil) {}
                }
            }
        }
    }
}

struct MoviesListMainView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListMainView(queryText: "", moviesListViewModel: .createDummy())
    }
}
