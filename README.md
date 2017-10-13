# talk-with-TalkAPI-for-Processing

## 概要

talkAPI、Julius、棒読みちゃんを駆使して、他人に肝心なところを丸投げしつつ人工知能と音声を使った会話を行うためのプログラム。  
大学の課題として超特急で開発を行うも意外と世間でやっている人はいなさそうだったので公開を行う

## 事前準備

##### ソフトウェアのダウンロード＆インストール
- JDKのインストール:  http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
- python
  -   Python3のインストール:  https://www.python.org/downloads/
  -  `pip install pya3rt` をcmdで実行してpython3にライブラリをダウンロード＆インストール
- Processingのダウンロード:  https://processing.org/
- talkAPIへ登録を行いAPIキーを入手する:  https://a3rt.recruit-tech.co.jp/product/talkAPI/
- Juliusのディクテーションキットのダウンロード:  http://julius.osdn.jp/index.php
- 棒読みちゃんのダウンロード:  http://chi.usamimi.info/Program/Application/BouyomiChan/

##### ソースコードの編集
- talkAPIのAPIキーをtalkAPI_client.pyの`apikey = ""`に代入する
- talkAPI_client.pyの完全パス（フルパス)をvoiceChat.pdeの`public static final String py_path="C:\\Users\talkAPI_client.py";`に代入する  
  - この時適当なパスを代入している上記のように\は\\\としてエスケープしないと動かないことに注意 

## 起動方法
- juliusのdictation-kitフォルダ内にある`run-win-dnn.bat`か`run-win-gmm.bat`をモジュールモードとして起動してください。モジュールモードで起動する方法は以下のURLを参考にしてください
 - gutugutu3030 juliusをモジュールモードで動かす　Processing  :https://sites.google.com/site/gutugutu30/other/juliuswomojurumododedongkasuprocessing
 - batファイルの編集がめんどくさい、よくわからないという方は本プロジェクトのsrcフォルダに入っている`dnn_talk_sample.bat`をそのままjuliusのdictation-kitフォルダに入れて起動してください。
 - 棒読みちゃんを起動してください。この時基本設定のsocket通信でsocket通信を行うがtrueになっていることを確認してください（デフォルトではなってるはず)
 - Processingから`voiceChat.pde`を実行してください。
 - 画面に話しかけてみて棒読みちゃんが返答をしてくれたら成功です。 
 ![起動画面](
 https://github.com/DjEunon/talk-with-TalkAPI-for-Processing/blob/master/doc_pic/md_cap.PNG?raw=true
 "起動画面")
## 参考文献  
#####  accessed 2017/7/19～2017/7/20


Processing  
https://processing.org/

棒読みちゃん  
http://chi.usamimi.info/Program/Application/BouyomiChan/

4÷7は割り切らない　Javaで棒読みさせるコードを書きました  
http://howalunar.hatenablog.com/entry/2012/01/14/215229

a3rt  
https://a3rt.recruit-tech.co.jp/

Qiita 機械学習API群A3RTをPythonから使う  
http://qiita.com/noco/items/466715f6dabe7374d545

Qiita Javaから外部プログラム「7-zip」を呼び出す。  
http://qiita.com/nogitsune413/items/48d69054b75ea9afbe5b

julius  
http://julius.osdn.jp/

gutugutu3030 juliusをモジュールモードで動かす　Processing  
https://sites.google.com/site/gutugutu30/other/juliuswomojurumododedongkasuprocessing

## 修正予定
なんか試行錯誤の後のソースや発表用の魔法のボタンが付いたままなので消す。  
汚いソースを書き直す。  
コメントをちゃんと入れる  
python無しでも動くようにjavaで何とかするコードを書く、無理そうならprocessingのpythonモードで動くように書き直す  
