import UIKit
// 粒子效果套件
import SpriteKit
// 音樂效果套件
import AVFoundation

class ViewController: UIViewController {
    
//        // AVPlayer 單次播放
//        let player = AVPlayer()
     
        //AVPlayerLooper 重複播放
        var looper:AVPlayerLooper?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Audi 圓圈標誌
        func circle(circleX:Int){
            // 畫一個圓
            let path = UIBezierPath(ovalIn: CGRect(x: circleX, y: 200, width: 80, height: 80))
                
            /* 生成代表形狀的 CAShapeLayer
        CAShapeLayer 可繪製特定的形狀，我們透過它的 path 設定形狀。然而 triangleLayer.path 的型別是 CGPath，所以我們無法指定剛剛生成的 UIBezierPath ，而須利用 path.cgPath 讀取 CGPath 型別的三角形路徑後再存入 triangleLayer.path
             */
            let buildLayer = CAShapeLayer()
            buildLayer.path = path.cgPath
                
            // 填滿形狀的顏色(預設會填滿黑色)
            buildLayer.fillColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
            // 填滿形狀的顏色設為透明
            buildLayer.fillColor = UIColor.clear.cgColor
                
            // 繪製線條的顏色
            buildLayer.strokeColor = UIColor.black.cgColor
            // 繪製線條的粗細
            buildLayer.lineWidth = 8
        
            // 將 CAShapeLayer 加到 view 上顯示出來
            view.layer.addSublayer(buildLayer)
        
        
            // 使用 CABasicAnimation 設定 Audi 標誌繪製動畫＊＊＊＊＊
            // strokeEnd 為畫線動畫效果。
            // strokeStart 為橡皮擦消除動畫效果
            let animation = CABasicAnimation(keyPath: "strokeEnd")
        
            // 設為 0 表示它將從 CAShapeLayer 路徑的起點開始
            animation.fromValue = 0
        
            // 設為 1 表示動畫將在畫到路徑終點時結束
            animation.toValue = 1
        
            // 設定動畫的時間(秒)
            animation.duration = 2.5
        
            // (可不特別設定)動畫的速度
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
            // (可不特別設定)重覆動畫
            animation.repeatCount = .greatestFiniteMagnitude
                
            // CAShapeLayer 加入設定的動畫條件
            buildLayer.add(animation, forKey: nil)
        }
        
        
        // GIF動畫＊＊＊＊＊＊＊＊＊
        // 方法1：旗幟(無限重複播放)
        let flagImageView = UIImageView(frame: CGRect(x: 50, y: 400, width: 150, height: 150))
        view.addSubview(flagImageView)
        
        let flagAnimatedImage = UIImage.animatedImageNamed("2e669c306dbc4a07c3c68f1b468265c3lubWU2LfzrjEcWJR-", duration: 0.5)
        flagImageView.image = flagAnimatedImage
        
        // 方法2：汽車(限制播放次數)
        let carImageView = UIImageView(frame: CGRect(x: 220, y: 400, width: 150, height: 150))
        view.addSubview(carImageView)
        
        // 先將動畫的每張圖片存入 array
        var images = [UIImage]()
        for i in 0...7 {
            images.append(UIImage(named: "0320093e37d74c488147a920401b04a9rISXu6FdnVxz7u2k-\(i)")!)
        }
        // 再將 array 存到 animationImages
        carImageView.animationImages = images
        // 動畫時間(秒)
        carImageView.animationDuration = 1
        // 動畫次數
        carImageView.animationRepeatCount = 3
        // 動畫最後靜止時的圖片
        carImageView.image = images[2]
        // 開始動畫, 令外停止動畫為 stopAnimating()
        carImageView.startAnimating()
        
        
        
        
        // SpriteKit 下雨背景(請先 import SpriteKit)＊＊＊＊＊＊＊＊＊
        // 先產生 SKView 物件
        let skView = SKView(frame: view.frame)
        // 將 skView 加入 view 底層當背景
        view.insertSubview(skView, at: 0)
        
        // SKView 顯示的內容由 SKScene 控制，因此我們產生 SKScene，然後從 skView 呼叫 presentScene 顯示 SKScene 的內容。
        let scene = SKScene(size: skView.frame.size)
        // 控制 scene 內容呈現的位置(型別是 CGPoint)，畫面的左下角為 (0, 0)，右上角為 (1, 1)
        scene.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        // 背景設為白色
        scene.backgroundColor = .white
        
        // 粒子效果設定
        let emitterNode = SKEmitterNode(fileNamed: "rainParticle")
        // 場景加入設定的粒子效果
        scene.addChild(emitterNode!)
        
        // 顯示 SKScene 內容
        skView.presentScene(scene)
        
        
        
        
        
        
        // 播放音樂(請先 import AVFoundation)＊＊＊＊＊＊＊＊＊＊
        
//        // 方法1：AVPlayer 單次播放

//        // 取得要播放的檔案位置
//        // 利用 Bundle.man 取得 App 主要的 Bundle，也就是 App 本身的資料夾。放在 Project navigator 下的 music.mp4
//        let fileUrl = Bundle.main.url(forResource: "engine", withExtension: "mp3")!
//
//        // 利用 AVPlayerItem 生成要播放的音樂
//        let playerItem = AVPlayerItem(url: fileUrl)
//
//        // 設定 player 要播放的 AVPlayerItem
//        player.replaceCurrentItem(with: playerItem)
//
//        // 調整音量(0~1)
//        player.volume = 1
//
//        // 開始播放音樂(停止播放為 player.pause())
//        player.play()
        
        
        // 方法2：AVPlayerLooper 重複播放
        if let url = Bundle.main.url(forResource: "engine", withExtension: "mp3")
        {

            // 生成 AVQueuePlayer 物件
            let player = AVQueuePlayer()

            // 利用 AVPlayerItem 生成要播放的音樂
            let playerItem = AVPlayerItem(url: url)

            // 生成 AVPlayerLooper，傳入剛剛生成的 player & item。到時候 AVPlayerLooper 將讓 item 重覆播放。
            looper = AVPlayerLooper(player: player, templateItem: playerItem)

            // 開始播放音樂(停止播放為 player.pause())
            player.play()
        }

        
        
        
        // Audi 文字
        let mark = UILabel(frame: CGRect(x: 130, y: 50, width: 200, height: 150))
        mark.text = "Audi"
        mark.textColor = .red
        mark.font = UIFont.systemFont(ofSize: 70)
        view.addSubview(mark)
        
        // Audi 四個圈圈繪製動畫
        circle(circleX: 70)
        circle(circleX: 130)
        circle(circleX: 190)
        circle(circleX: 250)

    }


}

