# Shakuten

Shakuten is a high-performance, native iOS video streaming platform built using SwiftUI, UIKit interoperability, and AVFoundation. Architected around decoupled feature modules, modern asynchronous structures, and strict memory safety controls, the codebase provides a predictable runtime environment engineered to scale cleanly.

---

## Technical Architecture Overview

The application utilizes a modular presentation structure based on an adapted MVVM pattern optimized for SwiftUI's declarative state mechanics. It separates core concerns into three clear operational layers: data models, asynchronous state processors, and lifecycle-aware user views.

### Core Engineering Rules
1. Unidirectional Presentation Layer: User actions update localized view states or trigger asynchronous tasks inside ViewModels. These ViewModels handle business logic and expose binding mutations back to the UI layout on the MainActor.
2. Concurrent Resource Safety: Intensive background tasks, such as networking and processing, run asynchronously using Swift Concurrency to decouple infrastructure pipelines from thread-constrained layout components.
3. Decoupled Modular Views: Interfaces are constructed using highly reusable child views that ingest immutable configuration instances rather than sharing massive global states.

---

## Codebase Architecture and Structural Mapping

The structural folder mapping matches your repository index:

```text
Shakuten/
├── App/
│   ├── AppContainer.swift                        # Core DI container and app navigation states
│   └── ShakutenApp.swift                         # Application lifecycle startup main configuration
├── Core/
│   ├── Enums/
│   │   └── VideoQuality.swift                    # Enum states specifying HLS peak bitrates
│   ├── Extensions/
│   │   └── Color+Hex.swift                       # Native Color primitives layout mapping overrides
│   ├── Launch/
│   │   └── LaunchScreen.storyboard               # Static runtime layout launch screen interface
│   ├── Models/
│   │   ├── SearchModel.swift                     # Structural schema maps for search results
│   │   └── StreamingContent.swift                # Immutable decodable models for shows and series
│   ├── Network/
│   │   ├── NetworkMonitor.swift                  # Core network path status monitoring interface
│   │   └── VideoService.swift                    # Data service layer handling video tracking
│   ├── Reusables/
│   │   ├── ButtonViews.swift                     # Standard control button components
│   │   ├── Colors.swift                          # Static design system color token maps
│   │   ├── GIFView.swift                         # Custom loading layout view rendering raw animations
│   │   ├── ScrollOffSetTracker.swift             # Coordinate space tracking interface for layouts
│   │   └── View+Extension.swift                  # Shared helper view modifier scope logic
│   └── Services/
│       └── CatalogService.swift                  # Content service compiling feed structures
└── Features/
    ├── Downloads/
    │   └── DwonloadView.swift                    # Offline cached metadata presentation file
    ├── TabView/
    │   └── MainView.swift                        # Shared root layout hosting application tabs
    ├── Home/
    │   ├── ViewModels/
    │   │   └── HomeViewModel.swift               # Core state layer driving content dashboard data
    │   └── Views/
    │       ├── ContentView.swift                 # Root dashboard layout frame setup
    │       ├── ErrorStateView.swift              # Fallback layout frame managing network errors
    │       ├── HomeCategoryStripView.swift       # Horizontal swipe tracking categorization layout
    │       ├── HomeHeroBannerView.swift          # Spotlight hero carousel configuration
    │       ├── HomeRailSectionView.swift         # Scrolling rail controller managing item cards
    │       └── ShowCardView.swift                # Poster image view element processing show bounds
    ├── Search/
    │   ├── View/
    │   │   ├── FilterSectionView.swift           # Filter configurations interface
    │   │   ├── SearchCatogeryGridView.swift      # Flexible category structural grids
    │   │   ├── SearchCatogeryViewList.swift      # List definitions mapping data queries
    │   │   └── SearchView.swift                  # Global search state text field view container
    │   │   └── TitleSearchBoxView.swift          # Specialized input display bar
    │   └── ViewModel/
    │       └── SearchViewModel.swift             # State machine tracking debounced search queries
    ├── VideoPlay/
    │   └── VideoPlay.swift                       # Custom landscape-constrained playback engine
    └── VideoPlayScreen/
        └── View/
            ├── CastHorizontalScrollView.swift    # Meta-row rendering show cast information
            ├── EpisodeRowView.swift              # Text line configuration styling episode targets
            ├── EpisodeVerticalScrollView.swift  # Scroll element tracking show episodic contents
            ├── MoreOptions.swift                 # Overlay drawer context panel selector
            ├── ShowPreviewView.swift             # Details preview wrapper block for previews
            └── VideoPlayScreen.swift             # Primary video tracking screen overlay dashboard
