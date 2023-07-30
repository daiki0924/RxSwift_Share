//
//  ViewController.swift
//  RxSwift+Share
//
//  Created by Daiki Kobayashi on 2023/07/30.
//

import RxRelay
import RxSwift
import UIKit

final class ViewController: UIViewController {
    /// 1つ目のsubscribeしている値を反映させるLabel
    @IBOutlet private weak var subscribeTextLabel1: UILabel!
    /// 2つ目のsubscribeしている値を反映させるLabel
    @IBOutlet private weak var subscribeTextLabel2: UILabel!
    /// 3つ目のsubscribeしている値を反映させるLabel
    @IBOutlet private weak var subscribeTextLabel3: UILabel!

    @IBOutlet private weak var button: UIButton!

    /// ボタンタップ時発火させる
    private let randomRelay: PublishRelay<Void> = .init()
    /// ランダムの数値を生成して流す
    private var randomObserver: Observable<Int>!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
        setupSubscribe()
    }

    private func createObserver() {
        randomObserver = randomRelay.map {
            let random = Int.random(in: 0 ... 100)
            print("🐶 shareをつけている場合ボタンタップ毎に1度だけ呼ばれる: \(random)")
            return random
        }
        .share() // ここのshareをコメントアウトしたらコメントインをして動作の違いを確認する
    }

    private func setupSubscribe() {
        randomObserver
            .subscribe(onNext: { [unowned self] random in
                print("🐶 subscribe1: \(random)")
                self.subscribeTextLabel1.text = "value1: \(random)"
            })
            .disposed(by: disposeBag)

        randomObserver
            .subscribe(onNext: { random in
                print("🐶 subscribe2: \(random)")
                self.subscribeTextLabel2.text = "value2: \(random)"
            })
            .disposed(by: disposeBag)

        randomObserver
            .subscribe(onNext: { random in
                print("🐶 subscribe3: \(random)")
                self.subscribeTextLabel3.text = "value3: \(random)"
            })
            .disposed(by: disposeBag)
    }

    // MARK: - イベント

    @IBAction private func didTap(_ button: UIButton) {
        randomRelay.accept(Void())
    }
}
