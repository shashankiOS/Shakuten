//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    enum ViewState: Equatable {
        case idle
        case loading
        case loaded
        case failed(String)
    }

    let screenTitle = "Shakuten"

    private let catalogService: CatalogServing
    private(set) var viewState: ViewState = .idle
    private(set) var featuredBanner = FeaturedBanner(
        title: "",
        subtitle: "",
        description: "",
        imageName: "play.rectangle.fill"
    )
    private(set) var categories: [ShowCategory] = []
    private var allShows: [Show] = []
    private var hasLoaded = false

    var searchText = ""
    var selectedCategoryID = ShowCategory.trending.id

    init(catalogService: CatalogServing) {
        self.catalogService = catalogService
    }

    var isLoading: Bool {
        viewState == .loading
    }

    var rails: [ShowRail] {
        [
            ShowRail(id: "continue-watching", title: "Continue Watching", shows: Array(filteredShows.prefix(4))),
            ShowRail(id: "featured-this-week", title: "Featured This Week", shows: filteredShows.filter(\.isFeatured)),
            ShowRail(id: "latest-episodes", title: "Latest Episodes", shows: filteredShows.filter(\.isNewEpisode))
        ]
        .filter { !$0.shows.isEmpty }
    }

    var errorMessage: String? {
        guard case let .failed(message) = viewState else { return nil }
        return message
    }

    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        await load()
    }

    func load() async {
        viewState = .loading

        do {
            let catalog = try await catalogService.fetchHomeCatalog()
            featuredBanner = catalog.featuredBanner
            categories = catalog.categories
            allShows = catalog.shows

            if !categories.contains(where: { $0.id == selectedCategoryID }) {
                selectedCategoryID = categories.first?.id ?? ShowCategory.trending.id
            }

            hasLoaded = true
            viewState = .loaded
        } catch {
            viewState = .failed("Unable to load shows right now.")
        }
    }

    func selectCategory(_ category: ShowCategory) {
        selectedCategoryID = category.id
    }

    private var filteredShows: [Show] {
        allShows.filter { show in
            matchesSelectedCategory(show) && matchesSearch(show)
        }
    }

    private func matchesSelectedCategory(_ show: Show) -> Bool {
        selectedCategoryID == ShowCategory.trending.id || show.categoryID == selectedCategoryID
    }

    private func matchesSearch(_ show: Show) -> Bool {
        guard !searchText.isEmpty else { return true }

        return show.title.localizedCaseInsensitiveContains(searchText)
            || show.genre.localizedCaseInsensitiveContains(searchText)
    }
}
