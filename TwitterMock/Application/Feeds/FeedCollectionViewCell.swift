//
//  FeedCollectionViewCell.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

final class FeedCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FeedCell"
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetViews()
    }
    
    override func prepareForReuse() {
        resetViews()
    }
    
    func set(viewModel: FeedCollectionViewCellViewModel) {
        viewModel.message
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.username
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: usernameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.createdTime
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: createdTimeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.imageHidden
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: photoImage.rx.isHidden)
            .disposed(by: disposeBag)
        
        avatarImage.sd_setImage(with: viewModel.avatarUrl,
                                placeholderImage: UIImage(named: "avatar"))
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        spinner.isHidden = false
        spinner.frame = avatarImage.frame
        spinner.startAnimating()
        photoImage.sd_setImage(with: viewModel.imageUrl,
                               placeholderImage: UIImage(named: "placeholder"),
                               options: []) { image, error, cacheType, imageURL in
                                spinner.stopAnimating()
        }
    }
    
    private func resetViews() {
        avatarImage.image = nil
        usernameLabel.text = nil
        createdTimeLabel.text = nil
        messageLabel.text = nil
        photoImage.image = nil
    }
    
}
