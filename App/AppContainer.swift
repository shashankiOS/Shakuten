import Foundation

struct AppContainer {
    let catalogService: CatalogServing

    static let live = AppContainer(catalogService: MockCatalogService())
}
