//
//  ViewController.swift
//  ARProject
//
//  Created by Viktor Andrén on 2017-10-24.
//  Copyright © 2017 Viktor Andrén. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show featurepoints/world origin
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        self.sceneView.autoenablesDefaultLighting = true
        
        sceneView.session.run(configuration)
    }
    
    @IBAction func addCube(_ sender: Any) {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x,cc.y,cc.z)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    struct myCameraCoordinate {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinate {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinate()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
