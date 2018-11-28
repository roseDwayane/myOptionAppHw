//
//  ViewController.swift
//  optionApp
//
//  Created by Derek on 2018/7/28.
//  Copyright © 2018年 Derek. All rights reserved.
//

import UIKit
import GameplayKit
import AVFoundation

struct Qna{
    var question:String
    var answer:[String]
    var correctAnwer:Int
}

class ViewController: UIViewController {
    
    @IBOutlet weak var myQuestion: UILabel!
    @IBOutlet weak var myQuestionNumber: UILabel!
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet var selectedButton: [UIButton]!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var mynextButton: UIButton!
    
    @IBOutlet weak var restartbutton: UIButton!
    
    @IBOutlet weak var firstImage: UILabel!
    
    @IBOutlet weak var tangImage: UIImageView!
 
    var audioPlayer:AVAudioPlayer?
    
    //題數
    var topicNumber = 0
    //正確答案
    var correctAnswerNumber = 0
    //分數
    var score = 0
    //不超過總題數
    var waringNumber = 0
    
    var questionArray = [Qna(question: "以下哪個不是音樂史上的三B？ ", answer: ["1. Brahms", "3. Bach", "2. Beethoven", "4. Berlioz"], correctAnwer: 4),Qna(question: "西洋音樂史中，以下哪一種為古典時期最重要的音樂曲式？ ", answer: ["1. 賦格", "3. 即興曲", "2. 大協奏曲",  "4. 奏鳴曲式"], correctAnwer: 4),Qna(question: "維也納古典樂派不包含哪位作曲家: ", answer: ["1. 莫札特", "3. 海頓", "2. 貝多芬", "4. 布拉姆斯"], correctAnwer: 4),Qna(question: "「歌劇的黃金時代」是指在音樂史上的那一時期: ", answer: ["1. 文藝復興時期","3. 古典時期","2. 浪漫時期","4. 印象主義時代"], correctAnwer: 2),Qna(question: "音樂史上聲樂曲和器樂曲同等份量的時期為何？", answer: ["1. 文藝復興","3. 巴洛克","2. 古典","4. 浪漫"], correctAnwer: 3),Qna(question: "檢視音樂史的演進過程，藝術歌曲蓬勃發展始於那一個時期： ", answer: ["1. 文藝復興","3. 巴洛克","2. 古典","4. 浪漫"], correctAnwer: 4)]
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {

        if waringNumber < 6{
            myQuestion.isHidden = false
            mynextButton.setTitle("next", for: .normal)
            myQuestion.text = questionArray[waringNumber].question
            correctAnswerNumber = questionArray[waringNumber].correctAnwer
            
            //用迴圈把答案選項放入按鈕,selectedButton是一個outlet collection
            for i in 0 ..< selectedButton.count{
                selectedButton[i].setTitle(questionArray[waringNumber].answer[i], for: .normal)
            }
            
            waringNumber += 1
            topicNumber += 1
            myQuestionNumber.text = "第\(topicNumber)題"
            
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            myQuestionNumber.isHidden = false
            firstImage.isHidden = true
        }else{
            warning()
            reStart()
            //mynextButton.setTitle("Play again!", for: .normal)
            waringNumber = 0
        }
        
    }
    
    
    
    @IBAction func selectedButton1(_ sender: UIButton) {
        
        if correctAnswerNumber == 1{
            score += 10
            myScore.text = "分數： \(score)"
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
        }else{
            score -= 10
            myScore.text = "分數： \(score)"
        }
        //總共六題，到第六題選項按下去就跳出總分視窗
        if waringNumber == 6{
            waringNumber = 0
            warning()
        }
    }
    
    
    @IBAction func selectedButton2(_ sender: UIButton) {
        
        if correctAnswerNumber == 2{
            score += 10
            myScore.text = "分數： \(score)"
            button1.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
        }else{
            score -= 10
            myScore.text = "分數： \(score)"
            
        }
        //總共六題，到第六題選項按下去就跳出總分視窗
        if waringNumber == 6{
            waringNumber = 0
            warning()
        }
       
    }
    
    @IBAction func selectedButton3(_ sender: UIButton) {
        if correctAnswerNumber == 3{
            score += 10
            myScore.text = "分數： \(score)"
            button1.isHidden = true
            button2.isHidden = true
            button4.isHidden = true
        }else{
            score -= 10
            myScore.text = "分數： \(score)"
        }
        //總共六題，到第六題選項按下去就跳出總分視窗
        if waringNumber == 6{
            waringNumber = 0
            warning()
        }
        
    }
    
    @IBAction func selectedButton4(_ sender: UIButton) {
        if correctAnswerNumber == 4{
            score += 10
            myScore.text = "分數： \(score)"
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
        }else{
            score -= 10
            myScore.text = "分數： \(score)"
            
        }
     //總共六題，到第六題選項按下去就跳出總分視窗
        if waringNumber == 6{
            waringNumber = 0
            warning()
        }
    }
    
    
    //重玩
    func reStart(){
        
        myQuestion.isHidden = true
        myQuestionNumber.isHidden = true
        firstImage.isHidden = false
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        topicNumber = 0
        score = 0
        myScore.text = "分數： ---"
        
        
    }
    
    //加入警告控制器
    func warning () {
        var myScore = ""
        if  score <= 20{
            myScore = "音樂素養母湯喔"
        }else if score >= 20 && score < 40{
            myScore = "感覺還可以"
        }else if score >= 40 && score < 60{
            myScore = "不可多得的高手"
        }
        else if score >= 60{
            myScore = "音樂天才"
        }
        let alert =  UIAlertController(title: myScore, message: "\(score)分", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "重新開始", style: .default, handler:{ UIAlertAction in  self.reStart()})
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //畫面讀入時取亂數(不會重複題目)
        questionArray.shuffle()
        
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        
        guard let newpath = Bundle.main.path(forResource: "backMusic", ofType: "wav") else {
            print("no such path")
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: newpath))
        }catch{
            print(error.localizedDescription)
            
        }
        audioPlayer?.play()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

