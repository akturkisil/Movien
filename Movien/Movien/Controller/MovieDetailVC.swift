//
//  ViewController.swift
//  Movien
//
//  Created by Işıl Aktürk on 21.02.2021.
//

import UIKit
import SDWebImage

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var detailPosterImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailVoteAverage: UILabel!
    @IBOutlet weak var detailReleaseDate: UILabel!
    @IBOutlet weak var detailOverview: UITextView!
    
    var selectedMovie: MovieDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataBinding()
    }
    
    func dataBinding() {
        detailTitle.text = selectedMovie!.title ?? ""
        detailOverview.text = selectedMovie!.overview ?? ""
        detailReleaseDate.text = changeDataFormmatter(date_string: selectedMovie!.release_date ?? "1010-01-01")
        detailVoteAverage.text = "\(selectedMovie!.vote_average ?? 0.0)"
        detailPosterImage.sd_setImage(with: URL(string: MoviesImagePath.moviesImagePath + "\(selectedMovie!.backdrop_path ?? "")"), completed: nil)
    }
    
    func changeDataFormmatter(date_string: String) -> String {
        //string to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date_string)
        
        //string to date
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date!)
    }
}
