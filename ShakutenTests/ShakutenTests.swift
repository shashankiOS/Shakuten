import Testing
@testable import Shakuten

@MainActor
struct ShakutenTests {
    @Test
    func loadBuildsRailsFromCatalog() async throws {
        let viewModel = HomeViewModel(catalogService: MockCatalogService())

        await viewModel.load()

        #expect(viewModel.viewState == .loaded)
        #expect(viewModel.categories.count == 6)
        #expect(viewModel.rails.isEmpty == false)
    }

    @Test
    func selectingCategoryFiltersShows() async throws {
        let viewModel = HomeViewModel(catalogService: MockCatalogService())
        await viewModel.load()

        viewModel.selectCategory(.comedy)

        #expect(viewModel.rails.count == 2)
    }
}
