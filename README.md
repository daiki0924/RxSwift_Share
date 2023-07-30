# RxSwift shareオペレータの基本動作
RxSwiftのshareオペレータを使用している時としてない時の基本的な動作を確認する。

## アプリの概要
・乱数を生成して流すObserverを1つ用意する
・1つのObserverを3つのsubscribeする
この時の動作を確認する。

## 確認できる動作
1. ボタンをタップ
2. randomRelayを発火
3. mapで乱数を生成して流すObserverに変更する
4. 変更したObserverをrandomObserverに格納する
5. randomObserverをsubscribeしている3箇所に生成した乱数が流れる
6. 3つのsubscribe箇所でそれぞれ流れてきた値が画面のLabelに反映される
この時にLabelに反映される値がshareを使用している時としていない時で変わる。

### shareオペレータを使用している時
画面に表示される3つのlabelに反映される値が全て同じになる。

### shareオペレータを使用しない時
画面に表示される3つのlabelに反映される値がそれぞれ別になる。


## この結果になる理由

### shareオペレータを使用している時
map内の処理がボタンタップの際に1度だけ行われ3つのsubscribeしている箇所で同じ値を使用しているため全てのlabelに反映される値が同じになる。

### shareオペレータを使用しない時
map内の処理がボタンタップの際にsubscribeしている数だけ処理が行われ3つのsubscribe箇所に別の値が流れるためlabelに反映される値が変わる。
