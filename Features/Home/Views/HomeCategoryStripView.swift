//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct HomeCategoryStripView: View {
    let categories: [ShowCategory]
    let selectedCategoryID: String
    let onCategorySelected: (ShowCategory) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories) { category in
                    Button {
                        withAnimation(.smooth) {
                            onCategorySelected(category)
                        }
                    } label: {
                        CategoryChipView(
                            title: category.title,
                            isSelected: selectedCategoryID == category.id
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

private struct CategoryChipView: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? .white : .white.opacity(0.08))
            .foregroundStyle(isSelected ? Color.black : .white)
            .clipShape(Capsule())
    }
}
