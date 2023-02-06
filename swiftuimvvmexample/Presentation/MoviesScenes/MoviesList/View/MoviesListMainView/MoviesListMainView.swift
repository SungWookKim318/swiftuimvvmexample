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
    @ObservedObject var moviesListViewModel: MoviesListViewModel
    var body: some View {
        VStack {
            SearchBarView(action: { [weak moviesListViewModel] text in
                moviesListViewModel?.requestSearch(query: text)
            })
            MoviesListView(items: $moviesListViewModel.items, selectedItem: $selectedItem) { [weak moviesListViewModel] selectedItem in
                moviesListViewModel?.selectMovie(item: selectedItem)
            }
                .clipped()
        }
    }
}

struct MoviesListMainView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListMainView(queryText: "", moviesListViewModel: .createDummy())
    }
}
