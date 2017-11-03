//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import NSObject_Rx
import func RxFeedback.bind
import class RxFeedback.Bindings
import UIKit

final class HomeViewController: UIViewController, Messageable {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var topRatedButton: UIButton!
    @IBOutlet private weak var upcomingButton: UIButton!
    @IBOutlet private weak var configButton: UIButton!
    @IBOutlet private weak var detailButton: UIButton!
    @IBOutlet private weak var nowPlayingButton: UIButton!
    
    // MARK: Dependency Injection
    
    lazy var movieGateway: MovieGateway = {
        return MovieGatewayFactory.make()
    }()
    
    lazy var configurationGateway: ConfigurationGateway = {
        return ConfigurationFactoryGateway.make()
    }()
    
    // MARK: Messageable conforms
    
    lazy var messageGateway: MessageGateway = {
        return MessageGatewayFactory.make()
    }()
    
    // MARK: UIViewController functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFeedback()
    }

    // MARK: Private Computed variables

    private var binding: HomeFeedback.Feedback {
        return bind(self, { (controller, state) in
            let subscriptions = [
                state.map({ $0.result }).drive(controller.textView.rx.text),
                state.map({ $0.error?.description }).drive(controller.rx.error)
            ]

            let events = [
                controller.popularButton.rx.tap.asSignal().map({ HomeEvent.popularSelected }),
                controller.topRatedButton.rx.tap.asSignal().map({ HomeEvent.topRatedSelected }),
                controller.upcomingButton.rx.tap.asSignal().map({ HomeEvent.upcomingSelected }),
                controller.configButton.rx.tap.asSignal().map({ HomeEvent.configSelected }),
                controller.detailButton.rx.tap.asSignal().map({ HomeEvent.detailSelected(id: "211672") }),
                controller.nowPlayingButton.rx.tap.asSignal().map({ HomeEvent.nowPlayingSelected })
            ]

            return Bindings(subscriptions: subscriptions, events: events)
        })
    }
    
    private var viewState: HomeState {
        return HomeStateFactory.make(movieGateway: movieGateway, configurationGateway: configurationGateway)
    }
    
    // MARK: Private functions
    
    private func setupFeedback() {
        HomeFeedback.system(initialState: viewState, ui: binding).drive().disposed(by: rx.disposeBag)
    }
}
