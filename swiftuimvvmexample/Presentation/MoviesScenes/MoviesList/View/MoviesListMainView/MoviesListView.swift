//
//  MoviesListView.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/03.
//

import SwiftUI

struct MoviesListView: View {
    @Binding var items: [MoviesListItemViewModel]
    var body: some View {
        List {
            ForEach(items, id: \.title) { item in
                Button {
                    // notice to view model
                } label: {
                    MoviesListItemView(itemData: item)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .listRowSeparator(.hidden, edges: .all)
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        let dummies: [MoviesListItemViewModel] = .init(repeating: .createDummy(), count: 5)
        MoviesListView(items: .constant(dummies))
    }
}
