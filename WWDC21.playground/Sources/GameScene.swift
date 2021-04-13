import PlaygroundSupport
import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var soundtrackAudioPlayer = AVAudioPlayer()
    var hazardsfxAudioPlayer = AVAudioPlayer()
//    2 gas players in case one is being used already
    var gassfxAudioPlayer = AVAudioPlayer()
    var gassfxAudioPlayer2 = AVAudioPlayer()
    
    var gameHasStarted : Bool = false
    var gameIsOver : Bool = false
    // represents starting gas level 40
    var gasMeter : Double = 2
    // make sure game over sound doesnt play multiple times
    var gameOverCount : Double = 0
    var gameEndSeconds : Double = 0
    
    var fadeOut : SKAction = SKAction.fadeAlpha(to: 0, duration: 0.7)
    var fadeIn : SKAction = SKAction.fadeAlpha(to: 1, duration: 1)

//    all variables of items in scene
    var gasTimer : Timer?
    var endTimer : Timer?
    
    var background : SKSpriteNode?
    var car : SKSpriteNode?
    
    var gas1 : SKSpriteNode?
    var gas2 : SKSpriteNode?
    var gas3 : SKSpriteNode?
    var gas4 : SKSpriteNode?
    var gas5 : SKSpriteNode?
    var gas6 : SKSpriteNode?
    var gas7 : SKSpriteNode?
    var gas8 : SKSpriteNode?
    var gas9 : SKSpriteNode?
    var gas10 : SKSpriteNode?
    var gas11 : SKSpriteNode?
    var gas12 : SKSpriteNode?
    var gas13 : SKSpriteNode?
    var gas14 : SKSpriteNode?
    var gas15 : SKSpriteNode?
    
    var hazard1 : SKSpriteNode?
    var hazard2 : SKSpriteNode?
    var hazard3 : SKSpriteNode?
    var hazard4 : SKSpriteNode?
    var hazard5 : SKSpriteNode?
    var hazard6 : SKSpriteNode?
    var hazard7 : SKSpriteNode?
    var hazard8 : SKSpriteNode?
    var hazard9 : SKSpriteNode?
    var hazard10 : SKSpriteNode?
    var hazard11: SKSpriteNode?
    var hazard12: SKSpriteNode?
    
    var gasIndicator : SKSpriteNode?
    var gmBackground : SKShapeNode?



    var endSign : SKSpriteNode?
    
    var gameOverScreen : SKLabelNode?
    var gameOverReason : SKLabelNode?

    override func didMove(to view: SKView) {
        
//        DEFINES AUDIO PLAYERS
        let soundtrack = Bundle.main.path(forResource: "greendale", ofType: "mp3")
        do {
            soundtrackAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundtrack!))
        } catch {
            print(error)
        }
//        -1 loops forever
        soundtrackAudioPlayer.numberOfLoops = -1
        soundtrackAudioPlayer.volume = 0.6
        soundtrackAudioPlayer.prepareToPlay()
        
        let hazardsfx = Bundle.main.path(forResource: "Gameoversfx", ofType: "wav")
        do {
            hazardsfxAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: hazardsfx!))
        } catch {
            print(error)
        }
        hazardsfxAudioPlayer.prepareToPlay()
        
        let gassfx = Bundle.main.path(forResource: "Gameoversfx2", ofType: "mp3")
        do {
            gassfxAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: gassfx!))
            gassfxAudioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: gassfx!))
        } catch {
            print(error)
        }
        
        gassfxAudioPlayer.volume = 0.8
        gassfxAudioPlayer.prepareToPlay()
        gassfxAudioPlayer2.volume = 0.8
        gassfxAudioPlayer2.prepareToPlay()

//        defines all nodes as they appear in Scene.sks
        gas1 = childNode(withName: "//Gas1") as? SKSpriteNode
        gas2 = childNode(withName: "//Gas2") as? SKSpriteNode
        gas3 = childNode(withName: "//Gas3") as? SKSpriteNode
        hazard1 = childNode(withName: "//Hazard1") as? SKSpriteNode
        hazard2 = childNode(withName: "//Hazard2") as? SKSpriteNode
        hazard3 = childNode(withName: "//Hazard3") as? SKSpriteNode
        hazard4 = childNode(withName: "//Hazard4") as? SKSpriteNode
        hazard5 = childNode(withName: "//Hazard5") as? SKSpriteNode
        hazard6 = childNode(withName: "//Hazard6") as? SKSpriteNode
        hazard7 = childNode(withName: "//Hazard7") as? SKSpriteNode
        hazard8 = childNode(withName: "//Hazard8") as? SKSpriteNode
        hazard9 = childNode(withName: "//Hazard9") as? SKSpriteNode
        hazard10 = childNode(withName: "//Hazard10") as? SKSpriteNode
        hazard11 = childNode(withName: "//Hazard11") as? SKSpriteNode
        hazard12 = childNode(withName: "//Hazard12") as? SKSpriteNode
        gas4 = childNode(withName: "//Gas4") as? SKSpriteNode
        gas5 = childNode(withName: "//Gas5") as? SKSpriteNode
        gas6 = childNode(withName: "//Gas6") as? SKSpriteNode
        gas7 = childNode(withName: "//Gas7") as? SKSpriteNode
        gas8 = childNode(withName: "//Gas8") as? SKSpriteNode
        gas9 = childNode(withName: "//Gas9") as? SKSpriteNode
        gas10 = childNode(withName: "//Gas10") as? SKSpriteNode
        gas11 = childNode(withName: "//Gas11") as? SKSpriteNode
        gas12 = childNode(withName: "//Gas12") as? SKSpriteNode
        gas13 = childNode(withName: "//Gas13") as? SKSpriteNode
        gas14 = childNode(withName: "//Gas14") as? SKSpriteNode
        gas15 = childNode(withName: "//Gas15") as? SKSpriteNode
        gasTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(useGas), userInfo: nil, repeats: true)
        gasIndicator = childNode(withName: "Indicator") as? SKSpriteNode
        endTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countEndSeconds), userInfo: nil, repeats: true)
        gmBackground = childNode(withName: "Gas Meter Background") as? SKShapeNode
        car = childNode(withName: "Car") as? SKSpriteNode
        background = childNode(withName: "Background") as? SKSpriteNode
        endSign = childNode(withName: "WelcomeSign") as? SKSpriteNode
        gameOverScreen = childNode(withName: "GameOver") as? SKLabelNode
        gameOverReason = childNode(withName: "//gameOverReason") as? SKLabelNode
    }
    
    public override func keyDown(with event: NSEvent) {
        if event.keyCode == 0 {
            print(background!.position)
        }
        if event.keyCode == 13 {
            print(car!.position)
        }
        if event.keyCode == 126 {
            if background!.position.y == 5000 {
                gameHasStarted = true
                moveSprite(node : background!, moveByX: 0, moveByY: -42500, forTheKey: "forward", duration: 35)
                moveSprite(node : endSign!, moveByX: 0, moveByY: -42500, forTheKey: "forward", duration: 35)
                soundtrackAudioPlayer.play()
            }
        }
        if event.keyCode == 123 {
            if car!.position.x >=  -676.5089721679688 && car!.position.x < 1172.4818115234375 {
                moveSprite(node: car!, moveByX: -400, moveByY: 0, forTheKey: "left", duration: 0.3)
            }
        }
        if event.keyCode == 124 {
            if car!.position.x >  -1076.5091552734375 && car!.position.x < 774.0081176757812 {
                moveSprite(node: car!, moveByX: 400, moveByY: 0, forTheKey: "right", duration: 0.3)

            }
        }
    }

    func moveSprite (node : SKNode, moveByX: CGFloat, moveByY: CGFloat, forTheKey: String, duration: TimeInterval) {
        let moveAction = SKAction.moveBy(x: moveByX, y: moveByY, duration: duration)
        let seq = SKAction.sequence([moveAction])

        node.run(seq, withKey: forTheKey)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
//        End Screen for completing game
        if gameIsOver {
            gameOverScreen!.text = "Congratulations!"
            gameOverReason!.text = "You Reached Cupertino Safely"
            car!.alpha = 0
            endSign!.alpha = 0
            background!.run(fadeOut)
            gameOverScreen!.run(fadeIn)
            gameOverReason!.run(fadeIn)
            if gameEndSeconds == 2 {
                moveSprite(node: gameOverScreen!, moveByX: -5000, moveByY: 0, forTheKey: "left", duration: 1)
            }
            if gameEndSeconds == 20 {
                soundtrackAudioPlayer.stop()
            }
        }
        
        if background!.position.y <= -37499 {
            gameIsOver = true
        }
        
//        STOPS GAS USAGE
        if background!.position.y <= -25500 {
            gameHasStarted = false
            gasIndicator!.run(fadeOut)
            gmBackground!.run(fadeOut)
        }
        
        
//        End Screen for running out of gas
        if gasMeter == 0 && gameOverCount == 0 {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "You Ran Out Of Gas"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
         
        
//        MAKES GAS CAN DISSAPEAR UPON INTERSECTION
        
        
        if car!.intersects(gas15!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas15!.removeFromParent()
            gas15!.removeAllActions()
            gas15!.removeAllChildren()
            gas15!.physicsBody = nil
            
            print(gasMeter)
            print( "gas15")
        }
        if car!.intersects(gas14!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas14!.removeFromParent()
            gas14!.removeAllActions()
            gas14!.removeAllChildren()
            gas14!.physicsBody = nil
            
            print(gasMeter)
            print( "gas14")
        }
        if car!.intersects(gas13!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas13!.removeFromParent()
            gas13!.removeAllActions()
            gas13!.removeAllChildren()
            gas13!.physicsBody = nil
            
            print(gasMeter)
            print( "gas13")
        }
        if car!.intersects(gas12!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas12!.removeFromParent()
            gas12!.removeAllActions()
            gas12!.removeAllChildren()
            gas12!.physicsBody = nil
            
            print(gasMeter)
            print( "gas12")
        }
        if car!.intersects(gas11!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas11!.removeFromParent()
            gas11!.removeAllActions()
            gas11!.removeAllChildren()
            gas11!.physicsBody = nil
            
            print(gasMeter)
            print( "gas11")
        }
        if car!.intersects(gas10!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas10!.removeFromParent()
            gas10!.removeAllActions()
            gas10!.removeAllChildren()
            gas10!.physicsBody = nil
            
            print(gasMeter)
            print( "gas10")
        }
        if car!.intersects(gas9!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas9!.removeFromParent()
            gas9!.removeAllActions()
            gas9!.removeAllChildren()
            gas9!.physicsBody = nil
            
            print(gasMeter)
            print( "gas9")
        }
        if car!.intersects(gas8!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas8!.removeFromParent()
            gas8!.removeAllActions()
            gas8!.removeAllChildren()
            gas8!.physicsBody = nil
            
            print(gasMeter)
            print( "gas8")
        }
        if car!.intersects(gas3!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas3!.removeFromParent()
            gas3!.removeAllActions()
            gas3!.removeAllChildren()
            gas3!.physicsBody = nil
            
            print(gasMeter)
            print(car!.intersects(gas3!))
            print( "gas3")
        }
        if car!.intersects(gas7!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas7!.removeFromParent()
            gas7!.removeAllActions()
            gas7!.removeAllChildren()
            gas7!.physicsBody = nil
            
            print(gasMeter)
            print( "gas7")
        }
        if car!.intersects(gas6!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas6!.removeFromParent()
            gas6!.removeAllActions()
            gas6!.removeAllChildren()
            gas6!.physicsBody = nil
            
            print(gasMeter)
            print( "gas6")
        }
        if car!.intersects(gas5!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas5!.removeFromParent()
            gas5!.removeAllActions()
            gas5!.removeAllChildren()
            gas5!.physicsBody = nil
            
            print(gasMeter)
            print( "gas5")
        }
        if car!.intersects(gas4!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas4!.removeFromParent()
            gas4!.removeAllActions()
            gas4!.removeAllChildren()
            gas4!.physicsBody = nil
            
            print(gasMeter)
            print( "gas4")
        }

        if car!.intersects(gas2!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            gas2!.removeFromParent()
            gas2!.removeAllActions()
            gas2!.removeAllChildren()
            gas2!.physicsBody = nil
            
            print(gasMeter)
            print( "gas2")
        }
        if car!.intersects(gas1!) {
            if gassfxAudioPlayer.isPlaying {
                gassfxAudioPlayer2.play()
            } else {
                gassfxAudioPlayer.play()
            }
            if (gasMeter <= 4 && gasMeter >= 1) {
                gasMeter += 1
            }
            
            gas1!.removeFromParent()
            gas1!.removeAllActions()
            gas1!.removeAllChildren()
            gas1!.physicsBody = nil
            print(gasMeter)
            print( "gas1")
        }
//        ENDS GAME ON HAZARD INTERSECTION
        
        if car!.intersects(hazard1!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard2!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard3!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard4!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard5!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard6!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard7!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard8!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard9!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard10!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard11!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        if car!.intersects(hazard12!) && gameOverCount == 0  {
            soundtrackAudioPlayer.stop()
            hazardsfxAudioPlayer.play()
            gameOverReason!.text = "Your Car Broke Down"
            background!.removeFromParent()
            endSign!.removeFromParent()
            car!.removeFromParent()
            gasIndicator!.removeFromParent()
            gmBackground!.removeFromParent()
            gameOverScreen!.alpha = 1
            gameOverReason!.alpha = 1
            gameOverCount += 1
        }
        
        //        CHANGES INDICATOR IMAGE BASED ON GAS AMOUNT
        if gasMeter == 1 {
            gasIndicator!.texture = SKTexture(imageNamed: "20%")
        }
        if gasMeter == 2 {
            gasIndicator!.texture = SKTexture(imageNamed: "40%")
        }
        if gasMeter == 3 {
            gasIndicator!.texture = SKTexture(imageNamed: "60%")
        }
        if gasMeter == 4 {
            gasIndicator!.texture = SKTexture(imageNamed: "80%")
        }
        if gasMeter == 5 {
            gasIndicator!.texture = SKTexture(imageNamed: "100%")
        }
    }
    
    @objc public static override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    @objc func useGas() {
        if gameHasStarted && (gasMeter <= 5 && gasMeter >= 1) {
            gasMeter -= 1
        }
    }
    @objc func countEndSeconds() {
        if gameIsOver {
            gameEndSeconds += 1
        }
    }
}
 
