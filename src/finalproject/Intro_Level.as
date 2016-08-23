/**
* 
* File:	 World.as
*
* Author:	 Georbec Ammon (u0552984@utah.edu) & Conan Zhang (conan.zhang@utah.edu)
* Date: 11-25-13
* Partner:	 Georbec Ammon / Conan Zhang
* Course:	 Computer Science 1410 - EAE
*
* Description:
*	 Main game world handles simulation and levels.
*  
**/
package finalproject
{
import VectorChildren.*;

import cdk.CollisionList;

import flash.display.Sprite;
import flash.events.*;
import flash.geom.Point;



public class Intro_Level extends Sprite
{
/**Screen**/
public var screen: Sprite;

/**Level**/
private var levelIntroComplete: Boolean = false;
private var floorOneComplete: Boolean = false;
private var currentCheckPoint: int = 1;

/**Difficulty**/
public var drawSpeed: Number = 1;
public var moveSpeed: Number = 1;

/**Vector Shapes**/
private var shapes:VectorShapes;

/**Mover/Collider Vectors**/
private var movers:Vector.<Particle>;
private var platformMovers:Vector.<Mover>;

/**TEST COLLISION**/
private var collisionList:CollisionList;

/**Physics**/
public const gravity : GeometricVector = new GeometricVector(0, -20);

/**Words**/
private var title: TITLE;
private var text1: CONTROLS;
private var text2: BORDER;
private var text3: CHECKPOINT;
private var text4: WALLJUMP;
private var text5: BORDERMOVED;
private var text6: TIMING;
private var text7: DOWNKEY;
private var text8: PORTALS;

public function Intro_Level(screenParameter:Sprite)
{
/**World**/
//Assign Members to Parameters
screen = screenParameter;

//Add to screen
screen.addChild(this);
//Center
this.x = stage.stageWidth/2;
this.y = stage.stageHeight/2;	
//Shapes class object
shapes = new VectorShapes();


/**WORDS**/
title = new TITLE();
title.x = 0;
title.y = -300;
this.addChild(title);

text1 = new CONTROLS();
text1.x = 0;
text1.y = -150;
this.addChild(text1);

text2 = new BORDER();
text2.x = 350;
text2.y = 125;
this.addChild(text2);

text3 = new CHECKPOINT();
text3.x = 900;
text3.y = -70;
this.addChild(text3);

text4 = new WALLJUMP();
text4.x = 800;
text4.y = -260;
this.addChild(text4);

text5 = new BORDERMOVED();
text5.x = 950;
text5.y = -550;
this.addChild(text5);

text6 = new TIMING();
text6.x = 1200;
text6.y = -400;
this.addChild(text6);

text7 = new DOWNKEY();
text7.x = 1750;
text7.y = -575;
this.addChild(text7);

text8 = new PORTALS();
text8.x = 2100;
text8.y = -650;
this.addChild(text8);



/**END WORDS**/

/**Movers**/
movers = new Vector.<Particle>(1);	
//Player
movers[0] = new Player(this, new Point(0, 0), new GeometricVector(0,10), 1);

//Platforms
platformMovers = new Vector.<Mover>(1);

platformMovers[0] = new MovingBaseVector(this, -1000, 0 , shapes.rectangleLoop.slice(), 10, 1*drawSpeed,1,0x00ff00,1,1,1,0, 1*moveSpeed, 100, 1);


/**Colliders**/
//create collision list with player as target
collisionList = new CollisionList(movers[0],

/**CHECKPOINTS**/
/**Floor 1**/
new CheckpointImmediateVector(this, -10, 10, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff,1,2),//checkpoint 1
new CheckpointImmediateVector(this, 700, 10, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff,1,2),//checkpoint 2

/**Floor 2**/
new CheckpointImmediateVector(this, 825, -325, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff,1,2),//checkpoint 3
new CheckpointImmediateVector(this, 1600, -500, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff,1,2),//checkpoint 4
new CheckpointImmediateVector(this, 1900, -500, shapes.rectangleLoop.slice(), 24, 1*drawSpeed, 1, 0x0000ff,1,2),//checkpoint 5

/**NORMAL PLATFORMS**/
/**Floor 1**/
//Beginning
new BaseVector(this, 300, 10, shapes.rectangleLoop.slice(), 13, 1, 1,0x00ff00, 1, 2),//first platform

//Wall Jump Section 1
new ImmediateBaseVector(this, 800, -150, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00, 1,1,1, 90),//platform 1
new ImmediateBaseVector(this, 600, -250, shapes.rectangleReverseLoop.slice(), 24, 1*drawSpeed,1,0x00ff00, 1,1,1, 90),//platform 2

/**Floor 2**/
//Platform/Badplatform section 1
new ImmediateBaseVector(this, 1200, -400, shapes.rectangleLoop.slice(), 24, 1*drawSpeed,1,0x00ff00,1, 3,2),//stair 1
new NoLoopBaseVector(this, 2400, -1425, shapes.stairsStart.slice(), 15, 1*drawSpeed,1,0x00ff00,1, -1.5,1.5),//stair 2

/**GOAL**/
new GoalNoLoopBaseVector(this, 2050, -500, shapes.spiralStart.slice(),75,2*drawSpeed, 3,0x101010, 1, 0.5,0.5),//goal 1

/**BAD PLATFORMS**/
/**Floor 1**/
//borderline
new BadImmediateVector(this, -1500, 100, shapes.borderLine.slice(),1,1,1,0xff0000,1,3 ),//borderline 1

/**Floor 2**/
//Platform/Badplatform section 1
new BadBaseVector(this, 1200, -400, shapes.rectangleLoop.slice(), 7, 1*drawSpeed, 1, 0xff0000, 1, 3,2),//bad platform 1
new BadImmediateVector(this, 1650, -660, shapes.spikesBack.slice(), 49, 2*drawSpeed, 1, 0xff0000, 1, 0.6,0.6),//spike 2	
new BadImmediateVector(this, 1650, -465, shapes.spikesBack.slice(), 49, 2*drawSpeed, 1, 0xff0000, 1, 0.6,0.6)//spike 2	

);
/**Start Simulation**/
start_simulation();
}

/**FUNCTION TO START SIMULATION BY UPDATING EVERYTHING ON GUI AND LOGICALLY**/
public function start_simulation(  ) : void
{
this.addEventListener( Event.ENTER_FRAME, updateAll );
}

/**FUNCTION TO END SIMULATION BY STOP UPDATING EVERY EVERYTHING ON GUI AND LOGICALLY**/
public function stop_simulation(  ) : void
{
this.removeEventListener( Event.ENTER_FRAME, updateAll );
}

/**FUNCTION TO UPDATE GUI AND LOGIC**/
protected function updateAll(event:Event):void
{	

/**Screen Follows Player**/
this.x = stage.stageWidth/2 - (Player)(movers[0]).getX();
this.y = stage.stageHeight/2 + (Player)(movers[0]).getY();

/**Movers**/
//Player
for each (var moverElement: Particle in movers)
{	
moverElement.add_force( gravity );//apply a negative velocity to all velocities to simulate gravity
moverElement.move( 0.1 );// tell movers to simulate 1/10 of a second of motion every frame to simulate movement
moverElement.clear_forces();//clear forces every frame to determine new calculations
}

//Platforms
for each (var platformMoverElement: Mover in platformMovers)
{	
platformMoverElement.move(777);//DURATION SHOULD DO NOTHING (PARAMETER)
}

/**BORDERLINE**/
if((Player)(movers[0]).location.y > 335 && floorOneComplete == false)
{

collisionList.addItem(	new BadImmediateVector(this, -1500, -305, shapes.borderLine.slice(),1,1,1,0xff0000,1,3 ) );//borderline 2

floorOneComplete = true;
}

/**COLLISIONS CHECK**/
//check for collisions
var collisions:Array = collisionList.checkCollisions();

//handle collisions
for(var i:int = 0; i < collisions.length; i++)
{
//first collision returned should always be player
var collision:Object = collisions[0];

collisionList.returnAngleType = "DEG";//angle is in degrees

//information of collision
var angle:Number = collision.angle;
var overlap:int = collision.overlapping.length;

//	 trace(angle);
//	 trace(overlap);
var collidedObject: String = collisions[i].object2;
var collidedObjectName: String = collisions[i].object2.name;
trace(collidedObjectName);

if(overlap > 0)
{
//player on top
if(angle > 75 && angle < 110)
{
(Player)(movers[0]).stabilize(1);//stabilize player
}
//player on bottom
if(angle > -110 && angle < -79)
{
(Player)(movers[0]).stabilize(2);//stabilize player
}
//player hits left side
if(angle < 75 && angle > -75)
{
(Player)(movers[0]).stabilize(3);//stabilize player

}
//player hits right side
if(angle < 180 && angle > 110 || angle > -180 && angle < -110)
{
(Player)(movers[0]).stabilize(4);//stabilize player

}

//Bad collision
if(collidedObject == "[object BadNoLoopBaseVector]" || collidedObject == "[object BadImmediateVector]" || collidedObject == "[object BadBaseVector]")
{
checkpointReset();
}
//Goal collision
else if(collidedObject == "[object GoalNoLoopBaseVector]")
{
while(numChildren > 0)
{
//Remove everything graphically
removeChildAt(0);

movers = null;
platformMovers = null;
collisionList = null;

if(levelIntroComplete == false)
{
var levelOne: Level_One = new Level_One(screen);
}
levelIntroComplete = true;

stop_simulation();
}


}
//Moving collision
else if(collidedObject == "[object MovingImmediateVector]")
{
//doesn't work
//	 if((BaseVector)(platformMovers[0]).isMovingLeft)
//	 {
//	 trace("moving left");
//	 (Player)(movers[0]).location.x -= (BaseVector)(platformMovers[0]).horizontalMoveSpeed*3;
//	 }
//	 else if((BaseVector)(platformMovers[0]).isMovingRight)
//	 {
//	 trace("moving right");
//	 (Player)(movers[0]).location.x += (BaseVector)(platformMovers[0]).horizontalMoveSpeed*3;
//	 }
//	 else if((BaseVector)(platformMovers[1]).isMovingUp)
//	 {
//	
//	 (Player)(movers[0]).location.y += (BaseVector)(platformMovers[1]).verticalMoveSpeed*1000;
//	 }
//	 else if((BaseVector)(platformMovers[1]).isMovingDown)
//	 {
//	 (Player)(movers[0]).location.y -= (BaseVector)(platformMovers[1]).verticalMoveSpeed*1000;
//	 }
}
//Checkpoint collision
else if(collidedObject == "[object CheckpointImmediateVector]")
{
if(collidedObjectName == "instance129")
{
//Checkpoint 1
currentCheckPoint = 1;
}
else if(collidedObjectName == "instance130")
{
//Checkpoint 2
currentCheckPoint = 2;
}
else if(collidedObjectName == "instance131")
{
//Checkpoint 2
currentCheckPoint = 3;
}
else if(collidedObjectName == "instance132")
{
//Checkpoint 2
currentCheckPoint = 4;
}
else if(collidedObjectName == "instance133")
{
//Checkpoint 2
currentCheckPoint = 5;
}
}

}
}
}

private function checkpointReset():void
{
if(currentCheckPoint == 1)
{
(Player)(movers[0]).reset(0, 0);
}
else if(currentCheckPoint == 2)
{
(Player)(movers[0]).reset( 700, 0);
}
else if(currentCheckPoint == 3)
{
(Player)(movers[0]).reset( 825, 300);
}
else if(currentCheckPoint == 4)
{
(Player)(movers[0]).reset( 1600, 500);
}
else if(currentCheckPoint == 5)
{
(Player)(movers[0]).reset( 1900, 500);
}
}
}//end class
}//end package