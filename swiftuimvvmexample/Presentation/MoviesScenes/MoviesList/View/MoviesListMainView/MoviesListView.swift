//
//  MoviesListView.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/03.
//

import SwiftUI

struct MoviesListView: View {
    @Binding var items: [MoviesListItemViewModel]
    @Binding var selectedItem: MoviesListItemViewModel?
    var action: (MoviesListItemViewModel) -> Void
    
    private let selectAnimationDuration = Animation.easeInOut(duration: 0.3)
    var body: some View {
        List {
            ForEach(items, id: \.title) { item in
                MoviesListItemView(itemData: item)
                    .listRowBackground(self.selectedItem == item ? Color.gray.animation(selectAnimationDuration) : Color.white.animation(selectAnimationDuration))
                    .onTapGesture {
                        self.selectedItem = item
                    }
            }
            .listRowSeparator(.hidden, edges: .all)
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        let dummies: [MoviesListItemViewModel] = .init(repeating: .createDummy(), count: 5)
        MoviesListView(items: .constant(dummies), selectedItem: .constant(nil), action: { item in })
    }
}
