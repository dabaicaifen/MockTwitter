//
//  FeedsCollectionViewController.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxSwift

final class FeedsCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
    @IBOutlet weak var newPostBarButton: UIBarButtonItem!
    
    var mockFeeds: Feeds?
    var viewModel: FeedsCollectionViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
        setupObservable()
        
        viewModel.didLoad()
    }
    
    private func setupViews() {
        let nib = UINib(nibName: String(describing: FeedCollectionViewCell.self), bundle: Bundle.main)
        collectionView?.register(nib, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        
        collectionView.refreshControl = UIRefreshControl()
    }
    
    private func setupViewModel() {
        viewModel.changeset
            .asDriver()
            .drive(onNext: { [weak self] changes in
                self?.collectionView.reloadData()
                self?.collectionView.refreshControl?.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupObservable() {
        newPostBarButton
            .rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.performSegue(withIdentifier: "showNewPost", sender: nil)
            })
            .disposed(by: disposeBag)
        
        logoutBarButton
            .rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.logout()
            })
            .disposed(by: disposeBag)
        
        collectionView.refreshControl?
            .rx.controlEvent(.valueChanged)
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.viewModel.refreshFeeds()
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: UICollectionViewDataSource
extension FeedsCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! FeedCollectionViewCell
        let feed = viewModel.item(at: indexPath.row)
        feed.map (cell.set(viewModel:))
        return cell
    }
    
}

extension FeedsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = viewModel.item(at: indexPath.row)
        return model?.cellSize ?? .zero
    }
    
}
