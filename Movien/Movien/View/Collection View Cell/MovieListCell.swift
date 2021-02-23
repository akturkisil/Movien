//
//  MovieListCell.swift
//  Movien
//
//  Created by Işıl Aktürk on 21.02.2021.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configureCell() {
        posterImageView.layer.cornerRadius = 10
    }
    
}
