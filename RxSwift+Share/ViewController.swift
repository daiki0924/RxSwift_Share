//
//  ViewController.swift
//  RxSwift+Share
//
//  Created by Daiki Kobayashi on 2023/07/30.
//

import UIKit
import RxSwift
import RxRelay

final class ViewController: UIViewController {
    
    /// ボタンタップ時発火させる
    private let randomRelay: PublishRelay<Void> = .init()
    /// ランダムの数値を生成して流す
    private var randomObserver: Observable<Int>!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createObserver()
        setupSubscribe()
    }
    
    private func setupView() {
        let button = UIButton()
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func createObserver() {
        randomObserver = randomRelay.map {
            // shareオペレータをつけている場合、randomObserverを複数箇所でsubscribeしている場合でも、
            // randomRelayが発火される度に1度だけmap内の処理が走る。
            // そのため複数箇所のsubscribeに流れる値は同じになる。
            // shareオペレータをつけて居ない場合は、randomRelayが発火した際にsubscribeしている数だけ、
            // map内の処理が走るためsubscribeしている箇所それぞれ値が違くなる。
            let random = Int.random(in: 0...10)
            print("🐶 random: \(random)")
            return random
        }
//        .share()
    }
    
    private func setupSubscribe() {
        randomObserver
            .subscribe(onNext: { random in
                print("🐶 subscribe1: \(random)")
            })
            .disposed(by: disposeBag)
        
        randomObserver
            .subscribe(onNext: { random in
                print("🐶 subscribe2: \(random)")
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - イベント

    @objc private func didTap(_ button: UIButton) {
        randomRelay.accept(Void())
    }
}

