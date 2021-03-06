# TheMovieDBSearch-IOS
The Movie DB Search 


# Prerequisites
xcode 9.4 <br />
swift 4.1 <br />
IOS : 10 or above<br />

# Dependency
This app additionally depends on following open source libraries.

[Moya](https://github.com/Moya/Moya)-   Moya is an HTTP networking library written in Swift.<br />
[Kingfisher](https://github.com/onevcat/Kingfisher) - A lightweight, pure-Swift library for downloading and caching images from the web.

# Architecture
The architecture of the app is MVVM (Model-View-ViewModel)  with outsourcing DataSource to make  ViewController more thin . we have two screen Search View and result view that is done UISearchViewController <br /><br />

 **SearchView** :  Display recent seach items and handel user input <br /><br />
 **ResultView** :  Have 5 state (Display loading,Display suggest, Display result , Display Error , loading more).This done with        Segmented Datasource and switch between them <br /><br />
    
    /// Index for State fo resultView that have tableview with 4 diffrent dataSource

```
/// Index for State fo resultView that have tableview with 4 diffrent dataSource
///
/// - suggest: suggest Datasource index 0
/// - loading: loading Datasource index 1
/// - error: error Datasource index 2
/// - ready: ready(results) Datasource index 3
/// - loadMore: load just we use footerview of table
enum State:Int{
    case suggest  = 0
    case loading  = 1
    case error    = 2
    case ready    = 3
    case loadMore = 4
}


/// Result View Model DataSource State
///
/// - results: load data source with search results
/// - suggest: load data source with suggest results
/// - error:  display error SearchMoviesError , Netwrok error
/// - loading: dataousrce in loading state
/// - loadingMore: loading more state   Bool indicate to refresh or  no more message

enum ResultViewDataSourceState {
    case results([MovieDisplayable])
    case suggest([SuggestStorage])
    case error (SearchMoviesError)
    case loading
    case loadingMore(Bool)
}

```

# ScreenShot

![simulator screen shot - iphone x - 2018-08-01 at 03 34 37](https://user-images.githubusercontent.com/32923534/43496148-08a87686-953c-11e8-905c-d77e88d7f9c8.png)

# Author
Abdelahad Darwish
