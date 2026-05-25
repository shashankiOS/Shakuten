import Foundation

struct HomeCatalog: Equatable {
    let featuredBanner: FeaturedBanner
    let categories: [ShowCategory]
    let shows: [Show]
}
struct Cast: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}
struct FeaturedBanner: Identifiable, Hashable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String
    let description: String
    let imageName: String

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        description: String,
        imageName: String
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.imageName = imageName
    }
}

struct ShowCategory: Identifiable, Hashable, Equatable {
    let id: String
    let title: String

    static let trending = ShowCategory(id: "trending", title: "Trending")
    static let romance = ShowCategory(id: "romance", title: "Romance")
    static let action = ShowCategory(id: "action", title: "Action")
    static let comedy = ShowCategory(id: "comedy", title: "Comedy")
    static let historical = ShowCategory(id: "historical", title: "Historical")
    static let reality = ShowCategory(id: "reality", title: "Reality")
}

struct Show: Identifiable, Hashable, Equatable {
    let id: String
    let title: String
    let genre: String
    let categoryID: String
    let year: Int
    let rating: Double
    let imageName: String
    let accentColorHex: String
    let isFeatured: Bool
    let isNewEpisode: Bool
}

struct ShowRail: Identifiable, Equatable {
    let id: String
    let title: String
    let shows: [Show]
}
struct Episode: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let duration: String
    let imageName: String
}
