//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import NSObject_Rx
import RxCocoa
import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var topRatedButton: UIButton!
    @IBOutlet private weak var upcomingButton: UIButton!
    @IBOutlet private weak var configButton: UIButton!
    @IBOutlet private weak var detailButton: UIButton!
    @IBOutlet private weak var nowPlayingButton: UIButton!
    
    // MARK: Rx
    
    lazy var viewModel: HomeViewModel = {
        let input = HomeViewModel.Input(popularTap: popularButton.rx.tap,
                                        topRatedTap: topRatedButton.rx.tap,
                                        upcomingTap: upcomingButton.rx.tap,
                                        configTap: configButton.rx.tap,
                                        detailTap: detailButton.rx.tap,
                                        nowPlayingTap: nowPlayingButton.rx.tap)
        
        return HomeViewModel(input: input)
    }()
    
    // MARK: UIViewController functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
    }
    
    // MARK: Functions
    
    private func setupRx() {
        viewModel.result.bind(to: textView.rx.text).disposed(by: rx.disposeBag)
    }
}
