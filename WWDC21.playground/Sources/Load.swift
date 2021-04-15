import PlaygroundSupport
import SpriteKit

var sceneView: SKView?
var scene: GameScene?
public func loadPrgm(_ shouldLoad: Bool) {
    guard shouldLoad else { print("Program not loaded successfully!"); return }
    
    // Load the 'GameScene.sks'
    sceneView = SKView(frame: CGRect(x:0 , y:0, width: 500, height: 500))
    if let s = GameScene(fileNamed: "Scene") {
        // save scene
        s.scaleMode = .aspectFit
        scene = s
    }
    print("Program loaded")
}

public var start: Void {
    guard let sceneView = sceneView, let scene = scene else { fatalError("ERR: Program was not loaded!") }
    
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}

