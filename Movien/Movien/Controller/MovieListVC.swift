//
//  MovieListVC.swift
//  Movien
//
//  Created by Işıl Aktürk on 21.02.2021.
//

import UIKit
import SDWebImage

class MovieListVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var revenueCollectionView: UICollectionView!
    @IBOutlet weak var mostVotedCollectionView: UICollectionView!
    
    //MARK: -Variables
    ///Popular Movies
    var popularMoviesArray: [MovieDetail] = []
    var popularMoviesTotalPage: Int = 0
    var popularMoviesCurrentPage: Int = 1
    var loadingPopularMoviesStatus: Bool = false
    
    ///Revenue Movies
    var revenueMoviesArray: [MovieDetail] = []
    var revenueMoviesTotalPage: Int = 0
    var revenueMoviesCurrentPage: Int = 1
    var loadingRevenueMoviesStatus: Bool = false
    
    ///Most Voted Movies
    var mostVotedMoviesArray: [MovieDetail] = []
    var mostVotedMoviesTotalPage: Int = 0
    var mostVotedMoviesCurrentPage: Int = 1
    var loadingMostVotedMoviesStatus: Bool = false
    
    //MARK: -Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegation & Datasource of collection views are on storyboard
        
        //Call APIs
        getPopularMovieList()
        getRevenueMovieList()
        getMostVotedMovieList()
        
    }
    
    //MARK: -Networking (APIs)
    func getPopularMovieList(current_page: Int = 1) { //URL Session
        
        // Prepare URL
        let url = URL(string: MovieBaseURL.movieBaseURL + "api_key=\(ApiKEY.apiKey)&" + "sort_by=\(SortTypes.popularity).\(SortedBy.descending.rawValue)&page=\(current_page)")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let data = data else {return}
            
            do {
                let movieListResponse = try JSONDecoder().decode(MovieList.self, from: data)
               
                if movieListResponse.results.count != 0 {
                    DispatchQueue.main.async {
                        
                        self.popularMoviesTotalPage = movieListResponse.total_pages
                        
                        if !self.loadingPopularMoviesStatus { //Page 1
                            self.popularMoviesArray = movieListResponse.results
                        } else {
                            let count = movieListResponse.results.count
                            var index = ((self.popularMoviesCurrentPage - 1) * 20)
                            for item in movieListResponse.results {
                                if index <= count + index - 1 {
                                    self.popularMoviesArray.insert(item, at: index)
                                    index = index + 1
                                }
                            }
                        }
                        
                        self.popularCollectionView.reloadData()
                        self.loadingPopularMoviesStatus = false
                    }
                } else {
                    print("There is no film in database.")
                }
            } catch let jsonError {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    print(jsonError)
                    let alert = UIAlertController(title: "Error", message: "Server Error", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
    
    func getRevenueMovieList(current_page: Int = 1) {
        
        let url = URL(string: MovieBaseURL.movieBaseURL + "api_key=\(ApiKEY.apiKey)&" + "sort_by=\(SortTypes.revenue).\(SortedBy.descending.rawValue)&page=\(current_page)")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let data = data else {return}
            do{
                
                let movieListResponse = try JSONDecoder().decode(MovieList.self, from: data)
                
                if movieListResponse.results.count != 0 {
                    DispatchQueue.main.async {
                        
                        self.revenueMoviesTotalPage = movieListResponse.total_pages
                        
                        if !self.loadingRevenueMoviesStatus {
                            self.revenueMoviesArray = movieListResponse.results
                        } else {
                            let count = movieListResponse.results.count
                            var index = ((self.revenueMoviesCurrentPage - 1) * 20)
                            for item in movieListResponse.results {
                                if index <= count + index - 1 {
                                    self.revenueMoviesArray.insert(item, at: index)
                                    index = index + 1
                                }
                            }
                        }
                        
                        self.revenueCollectionView.reloadData()
                        self.loadingRevenueMoviesStatus = false
                        
                    }
                } else {
                    print("There is no film in db.")
                }
            }catch let jsonError{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    print(jsonError)
                    let alert = UIAlertController(title: "Error", message: "Server Error", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
    
    func getMostVotedMovieList(current_page: Int = 1) {
        
        let url = URL(string: MovieBaseURL.movieBaseURL + "api_key=\(ApiKEY.apiKey)&" + "sort_by=\(SortTypes.voteCount).\(SortedBy.descending.rawValue)&page=\(current_page)")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let data = data else {return}
            do{
                let movieListResponse = try JSONDecoder().decode(MovieList.self, from: data)
                
                if movieListResponse.results.count != 0 {
                    DispatchQueue.main.async {
                        
                        self.mostVotedMoviesTotalPage = movieListResponse.total_pages
                        
                        if !self.loadingMostVotedMoviesStatus {
                            self.mostVotedMoviesArray = movieListResponse.results
                        } else {
                            let count = movieListResponse.results.count
                            var index = ((self.mostVotedMoviesCurrentPage - 1) * 20)
                            for item in movieListResponse.results {
                                if index <= count + index - 1 {
                                    self.mostVotedMoviesArray.insert(item, at: index)
                                    index = index + 1
                                }
                            }
                        }
                        
                        self.mostVotedCollectionView.reloadData()
                        self.loadingMostVotedMoviesStatus = false
                        
                    }
                } else {
                    print("There is no film in db.")
                }
            }catch let jsonError{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    print(jsonError)
                    let alert = UIAlertController(title: "Error", message: "Server Error", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
    
    //MARK: -Infinity Scrolling (for pagination)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // calculates where the user is in the x-axis
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        
        if offsetX > contentWidth - scrollView.frame.size.width {
            if scrollView == popularCollectionView {
                self.loadMorePopularMovies()
            } else if scrollView == revenueCollectionView {
                self.loadMoreRevenueMovies()
            } else {
                self.loadMoreMostVotedMovies()
            }
        }
        
    }
    
    func loadMorePopularMovies() {
        if !loadingPopularMoviesStatus {
            popularMoviesCurrentPage += 1
            loadingPopularMoviesStatus = true
            if popularMoviesTotalPage >= popularMoviesCurrentPage {
                self.getPopularMovieList(current_page: popularMoviesCurrentPage)
            }
        }
    }
    
    func loadMoreRevenueMovies() {
        if !loadingRevenueMoviesStatus {
            revenueMoviesCurrentPage += 1
            loadingRevenueMoviesStatus = true
            if revenueMoviesTotalPage >= revenueMoviesCurrentPage {
                self.getRevenueMovieList(current_page: revenueMoviesCurrentPage)
            }
        }
    }
    
    func loadMoreMostVotedMovies() {
        if !loadingMostVotedMoviesStatus {
            mostVotedMoviesCurrentPage += 1
            loadingMostVotedMoviesStatus = true
            if mostVotedMoviesTotalPage >= mostVotedMoviesCurrentPage {
                self.getMostVotedMovieList(current_page: mostVotedMoviesCurrentPage)
            }
        }
    }
    
}

//MARK: -MovieListVC Collection View Delegate & Datasource
extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollectionView {
            return popularMoviesArray.count
        } else if collectionView == revenueCollectionView {
            return revenueMoviesArray.count
        } else {
            return mostVotedMoviesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! MovieListCell
            cell.configureCell()
            cell.posterImageView.sd_setImage(with: URL(string: MoviesImagePath.moviesImagePath + "\(popularMoviesArray[indexPath.row].poster_path ?? "")"), completed: nil)
            return cell
        } else if collectionView == revenueCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "revenueCell", for: indexPath) as! MovieListCell
            cell.configureCell()
            cell.posterImageView.sd_setImage(with: URL(string: MoviesImagePath.moviesImagePath + "\(revenueMoviesArray[indexPath.row].poster_path ?? "")"), completed: nil)
            return cell
        } else { // Most Voted collection view
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mostVotedCell", for: indexPath) as! MovieListCell
            cell.configureCell()
            cell.posterImageView.sd_setImage(with: URL(string: MoviesImagePath.moviesImagePath + "\(mostVotedMoviesArray[indexPath.row].poster_path ?? "")"), completed: nil)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailVC") as! MovieDetailVC
        
        if collectionView == popularCollectionView {
            destinationVC.selectedMovie = popularMoviesArray[indexPath.row]
        } else if collectionView == revenueCollectionView {
            destinationVC.selectedMovie = revenueMoviesArray[indexPath.row]
        } else {
            destinationVC.selectedMovie = mostVotedMoviesArray[indexPath.row]
        }
        
        self.present(destinationVC, animated: true, completion: nil)
   
    }
    
}

