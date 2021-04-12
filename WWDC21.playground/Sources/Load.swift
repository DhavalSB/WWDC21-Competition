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
    print("Program successfully loaded in!")
}

public func showStats() {
    if let sceneView = sceneView {
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        sceneView.showsFields = true
        sceneView.showsQuadCount = true
        sceneView.showsDrawCount = true
    }
}

public var start: Void {
    guard let sceneView = sceneView, let scene = scene else { fatalError("ERR: Program was not loaded!") }
    
    sceneView.presentScene(scene)
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}

