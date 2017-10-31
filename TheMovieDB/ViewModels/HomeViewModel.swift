//
//  HomeViewModel.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import RxCocoa
import RxSwift
import RxMoya
import Moya
import NSObject_Rx

final class HomeViewModel: HasDisposeBag {
    let result = PublishSubject<String>()
    
    struct Input {
        let popularTap: ControlEvent<Void>
        let topRatedTap: ControlEvent<Void>
        let upcomingTap: ControlEvent<Void>
        let configTap: ControlEvent<Void>
        let detailTap: ControlEvent<Void>
        let nowPlayingTap: ControlEvent<Void>
    }
    
    init(input: Input) {
        let configProvider = MoyaProvider<ConfigurationTarget>()
        let movieProvider = MoyaProvider<MovieTarget>()
        
        input.popularTap
            .flatMap({ movieProvider.rx.request(.popular).mapString() })
            .bind(to: result)
            .disposed(by: disposeBag)
        
        input.topRatedTap
            .flatMap({ movieProvider.rx.request(.topRated).mapString() })
            .bind(to: result)
            .disposed(by: disposeBag)
        
        input.upcomingTap
            .flatMap({ movieProvider.rx.request(.upcoming).mapString() })
            .bind(to: result)
            .disposed(by: disposeBag)
        
        input.configTap
            .flatMap({ configProvider.rx.request(.configuration).mapString() })
            .bind(to: result)
            .disposed(by: disposeBag)
        
        input.detailTap
            .flatMap({ movieProvider.rx.request(.detail(id: "211672")).mapString() })
            .bind(to: result)
            .disposed(by: disposeBag)
        
        input.nowPlayingTap
            .flatMap({ movieProvider.rx.request(.nowPlaying).mapString() })
            .bind(to: result)
            .disposed(by: disposeBag)
    }
}
