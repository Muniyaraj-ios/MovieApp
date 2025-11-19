<h1 align="center">🎬 MovieApp — TMDb Movie Browser (SwiftUI + MVVM)</h1>

<p align="center">
A clean, modern movie browsing application built using <b>SwiftUI</b>, <b>Combine</b>, <b>async/await</b>, and <b>TMDb API</b>.
<br>
Features: popular movies, search with debounce, pagination, detail screens, trailers, cast & crew, and favorites.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9-orange?logo=swift" />
  <img src="https://img.shields.io/badge/Xcode-15+-blue?logo=xcode" />
  <img src="https://img.shields.io/badge/iOS-16+-lightgrey?logo=apple" />
  <img src="https://img.shields.io/badge/Architecture-MVVM-green" />
  <img src="https://img.shields.io/badge/API-TMDb-blue?logo=themoviedatabase" />
</p>

<hr>

<h2>🚀 Features</h2>

<h3>🏠 Popular Movies (Home)</h3>
<ul>
  <li>Fetches popular movies from TMDb API</li>
  <li>Infinite scrolling (pagination)</li>
  <li>Movie cards with poster, title, rating, release year</li>
  <li>Navigation to detail page</li>
</ul>

<h3>🔍 Search</h3>
<ul>
  <li>Real-time search with <b>Combine debounce</b></li>
  <li>Instant results</li>
  <li>Separate listing for search results</li>
</ul>

<h3>🎥 Movie Detail Page</h3>
<ul>
  <li>Backdrop + poster layout</li>
  <li>Title, year, runtime, country, status</li>
  <li>Circular rating meter</li>
  <li>Genre chips</li>
  <li>Overview with “Read more / Read less”</li>
  <li>Cast & crew lists (horizontal scroll)</li>
  <li>YouTube trailer support via SafariView</li>
</ul>

<h3>⭐ Favorites</h3>
<ul>
  <li>Add/remove favorites</li>
  <li>Favorites persist using <b>UserDefaults</b></li>
  <li>Syncs between list and detail screens</li>
</ul>

<hr>

<h2>🛠 Technical Stack</h2>
<ul>
  <li><b>SwiftUI</b></li>
  <li><b>MVVM architecture</b></li>
  <li><b>URLSession</b> + async/await</li>
  <li><b>Combine</b> for search debounce</li>
  <li><b>TMDb API</b></li>
  <li><b>SafariServices</b> for trailer playback</li>
  <li>Custom <b>AsyncImageView</b> for images</li>
</ul>

<hr>

<h2>📁 Project Structure</h2>

<pre>
MovieApp/
│
├── MovieAppApp.swift
│
├── Views/
│   ├── MoviesListView.swift
│   ├── MovieDetailView.swift
│   └── Components/
│       ├── AsyncImageView.swift
│       ├── SafariView.swift
│       ├── GenreChip.swift
│       ├── RatingCircle.swift
│       └── CastView.swift
│
├── ViewModels/
│   ├── MovieListViewModel.swift
│   └── MovieDetailViewModel.swift
│
├── Network/
│   ├── NetworkService.swift
│   ├── NetworkParams.swift
│   └── EndPoint.swift
│
├── Models/
│   ├── MovieListModel.swift
│   ├── MovieDetailModel.swift
│   ├── CastData.swift
│   ├── CrewData.swift
│   └── SearchModels.swift
│
└── Helpers/
    ├── JSONLocal.swift
    ├── BaseSwiftyJSON.swift
    └── Extensions/
</pre>

<hr>

<h2>🔧 Setup Instructions</h2>

<h3>1️⃣ Clone the Repository</h3>

<pre>
git clone https://github.com/Muniyaraj-ios/MovieApp.git
cd MovieApp
</pre>

<h3>2️⃣ Open in Xcode</h3>
<p>Xcode 15+ required (iOS 16+).</p>

<h3>3️⃣ Add TMDb API Key</h3>
<p>In <code>NetworkParams.swift</code>, update:</p>

<pre>
let apiKey = "&lt;YOUR_TMDB_API_KEY&gt;"
</pre>

<p>Get your key: <a href="https://developer.themoviedb.org/">TMDb Developer</a></p>

<h3>4️⃣ Run the App</h3>
<p>Choose a simulator → <b>Cmd + R</b></p>

<hr>

<h2>💡 Assumptions</h2>
<ul>
  <li>App covers only movie APIs</li>
  <li>YouTube trailers only</li>
  <li>Light persistence via UserDefaults</li>
  <li>Only first trailer used</li>
  <li>Network errors minimally handled</li>
</ul>

<hr>

<h2>⚠️ Known Limitations</h2>
<ul>
  <li>No separate cast/crew detail screens</li>
  <li>No recommendation section</li>
  <li>No offline support</li>
  <li>Trailer opens in Safari (YouTube embed restricted)</li>
  <li>Not optimized for iPad/landscape</li>
</ul>

<hr>

<h2>📸 Screenshots</h2>

<p align="center">
  <!-- Replace with your actual screenshot links -->
  <img src="Screenshots/home.png" width="300">
  <img src="Screenshots/detail.png" width="300">
</p>

<hr>

<h2>👨‍💻 Author</h2>
<p><b>Munish</b><br>iOS Developer (SwiftUI • MVVM • Combine)</p>

<hr>

<h2>📄 License</h2>
<p>This project is for learning and interview evaluation purposes only.</p>
