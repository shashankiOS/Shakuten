import Foundation

protocol CatalogServing {
    func fetchHomeCatalog() async throws -> HomeCatalog
}

struct MockCatalogService: CatalogServing {
    func fetchHomeCatalog() async throws -> HomeCatalog {
        HomeCatalog(
            featuredBanner: FeaturedBanner(
                title: "When the City Sleeps",
                subtitle: "New episodes every Friday",
                description: "A glossy Seoul thriller with romance, betrayal, and a rooftop chase every episode.",
                imageName: "citySleeps"
            ),
            categories: [
                .trending,
                .romance,
                .action,
                .comedy,
                .historical,
                .reality
            ],
            shows: [
                Show(id: "midnight-market", title: "Midnight Market", genre: "Thriller", categoryID: ShowCategory.trending.id, year: 2024, rating: 8.8, imageName: "midnightMarket", accentColorHex: "#3F5EFB", isFeatured: false, isNewEpisode: true),
                Show(id: "summer-at-jeju", title: "Summer at Jeju", genre: "Drama", categoryID: ShowCategory.trending.id, year: 2023, rating: 8.7, imageName: "summerAtJeju", accentColorHex: "#E9B44C", isFeatured: false, isNewEpisode: false),

                Show(id: "laugh-club", title: "Laugh Club", genre: "Comedy", categoryID: ShowCategory.comedy.id, year: 2024, rating: 8.5, imageName: "laughClub", accentColorHex: "#35A7FF", isFeatured: true, isNewEpisode: false),

                Show(id: "code-name-seoul", title: "Code Name Seoul", genre: "Action", categoryID: ShowCategory.action.id, year: 2025, rating: 9.0, imageName: "codeNameSeoul", accentColorHex: "#FF7A18", isFeatured: false, isNewEpisode: false),
                Show(id: "royal-secret", title: "Royal Secret", genre: "Historical", categoryID: ShowCategory.historical.id, year: 2022, rating: 9.3, imageName: "royalSecret", accentColorHex: "#6A4C93", isFeatured: true, isNewEpisode: false),
                Show(id: "street-chef-war", title: "Street Chef War", genre: "Reality", categoryID: ShowCategory.reality.id, year: 2025, rating: 8.9, imageName: "streetChefWar", accentColorHex: "#00A878", isFeatured: false, isNewEpisode: true),
                Show(id: "love-in-han-river", title: "Love in Han River", genre: "Romance", categoryID: ShowCategory.romance.id, year: 2025, rating: 9.1, imageName: "love-in-han-river", accentColorHex: "#E54B6B", isFeatured: true, isNewEpisode: true)

            ]
        )
    }
}
