//
//  SearchViewModel.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {
    var searchText : String = ""
    let filterModel: FilterModel
    init(filterModel: FilterModel) {
        self.filterModel = filterModel
    }
    var shows : [Show] = [
        Show(id: "midnight-market", title: "Midnight Market", genre: "Thriller", categoryID: ShowCategory.trending.id, year: 2024, rating: 8.8, imageName: "midnightMarket", accentColorHex: "#3F5EFB", isFeatured: false, isNewEpisode: true),
        Show(id: "code-name-seoul", title: "Code Name Seoul", genre: "Action", categoryID: ShowCategory.action.id, year: 2025, rating: 9.0, imageName: "codeNameSeoul", accentColorHex: "#FF7A18", isFeatured: false, isNewEpisode: false),
        Show(id: "summer-at-jeju", title: "Summer at Jeju", genre: "Drama", categoryID: ShowCategory.trending.id, year: 2023, rating: 8.7, imageName: "summerAtJeju", accentColorHex: "#E9B44C", isFeatured: false, isNewEpisode: false),
        Show(id: "laugh-club", title: "Laugh Club", genre: "Comedy", categoryID: ShowCategory.comedy.id, year: 2024, rating: 8.5, imageName: "laughClub", accentColorHex: "#35A7FF", isFeatured: true, isNewEpisode: false),
        Show(id: "royal-secret", title: "Royal Secret", genre: "Historical", categoryID: ShowCategory.historical.id, year: 2022, rating: 9.3, imageName: "royalSecret", accentColorHex: "#6A4C93", isFeatured: true, isNewEpisode: false),
        Show(id: "street-chef-war", title: "Street Chef War", genre: "Reality", categoryID: ShowCategory.reality.id, year: 2025, rating: 8.9, imageName: "streetChefWar", accentColorHex: "#00A878", isFeatured: false, isNewEpisode: true),
        Show(id: "love-in-han-river", title: "Love in Han River", genre: "Romance", categoryID: ShowCategory.romance.id, year: 2025, rating: 9.1, imageName: "love-in-han-river", accentColorHex: "#E54B6B", isFeatured: true, isNewEpisode: true)

    ]
    let regions: [String] = [
        "India",
        "South Korea",
        "Japan",
        "China",
        "Thailand",
        "United States",
        "United Kingdom",
        "Spain",
        "France",
        "Germany"
    ]
    let genres : [String] = [
        "Action",
        "Adventure",
        "Fantasy",
        "Horror",
        "Romance",
        "Thriller",
        "Comedy",
        "Drama",
        "Science Fiction"]
    let format : [String] = [
        "1080P",
        "4K",
        "720P",
        "2K"

    ]

    
}

