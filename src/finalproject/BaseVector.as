package finalproject
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class BaseVector extends Sprite implements Collider, Mover
	{
		/**Drawing**/
		protected var points                   : Vector.<Point>;
		protected var numberOfLinesShown       : int;
		protected var index                    : int;
		protected var drawSpeed                : int;
		
		/**Line Style**/
		protected var lineThickness            : Number;
		protected var lineColor                : Number;
		protected var lineAlpha                : Number;
		
		/**Location**/
		protected var xCoordinate              : Number;
		protected var yCoordinate              : Number;
		
		/**Movement**/
		public var horizontalMoveSpeed      : Number;
		public var verticalMoveSpeed        : Number;
		
		//Horizontal
		public var isMovingLeft             : Boolean;
		public var isMovingRight            : Boolean;
		protected var horizontalLimit          : Number;
		//Vertical
		public var isMovingUp               : Boolean;
		public var isMovingDown             : Boolean;
		protected var verticalLimit            : Number;
		//Rotation
		protected var speedOfRotation          : Number;
		
		//Initial direction
		//horizontal
		protected const HORIZONTAL_NONE        : int = -1;
		protected const HORIZONTAL_RANDOMIZED  : int = 0;
		protected const HORIZONTAL_LEFT        : int = 1;
		protected const HORIZONTAL_RIGHT       : int = 2;
		protected var horizontalDirection      : int;
		
		//vertical
		protected const VERTICAL_NONE          : int = -1;
		protected const VERTICAL_RANDOMIZED    : int = 0;
		protected const VERTICAL_UP            : int = 1;
		protected const VERTICAL_DOWN          : int = 2;
		protected var verticalDirection        : int;
		
		/**Timer**/
		protected var timer: Timer;		
		
		/**Constructor**/
		public function BaseVector(world                             : Sprite,
								   xCoordinateParameter              : Number,
								   yCoordinateParameter 	         : Number,
								   pointsParameter                   : Vector.<Point>,
							       numberOfLinesShownParameter       : int,
								   drawSpeedParameter                  : int    = 1,
							       lineThicknessParameter              : Number = 1,
							       lineColorParameter                  : Number = 0x00ff00,
							       lineAlphaParameter                  : Number = 1,
								   scalarXParameter						:Number = 1,
								   scalarYParameter						:Number = 1,
								   initialRotationParameter				:Number = 0,
							       horizontalMoveSpeedParameter        : Number = 1,
								   horizontalLimitParameter            : Number = 100,
								   horizontalDirectionParameter        : int    = -1,
								   verticalMoveSpeedParameter          : Number = 1,
								   verticalLimitParameter              : Number = 100,
								   verticalDirectionParameter          : int    = -1,
								   speedOfRotationParameter            : Number = 0)
		{
			/**Add to World**/
			world.addChild(this);
			
			/**Fill Member Variables**/
			//Location
			xCoordinate     = xCoordinateParameter;
			yCoordinate		= yCoordinateParameter;
			
			//Drawing
			points = pointsParameter;
			drawSpeed = drawSpeedParameter;
			
			//Line
			numberOfLinesShown = numberOfLinesShownParameter;
			lineThickness = lineThicknessParameter;
			lineColor = lineColorParameter;
			lineAlpha = lineAlphaParameter;
			
			//Movement
			horizontalMoveSpeed = horizontalMoveSpeedParameter;
			horizontalLimit = horizontalLimitParameter;
			horizontalDirection = horizontalDirectionParameter;
			
			verticalMoveSpeed = verticalMoveSpeedParameter;
			verticalLimit = verticalLimitParameter;
			verticalDirection = verticalDirectionParameter;
			
			this.rotation = initialRotationParameter;
			speedOfRotation = speedOfRotationParameter;
				
			index = 0;
			
			/**Create display list**/
			timer = new Timer(75);
			timer.addEventListener(TimerEvent.TIMER, draw);
			timer.start();
			
			/**Location**/
			this.x = xCoordinate;
			this.y = yCoordinate;
			
			/**Size**/
			this.scaleX = scalarXParameter;
			this.scaleY = scalarYParameter;

			
			/**Vertical initial direction**/
			if(verticalDirection == VERTICAL_UP)
			{
				isMovingUp = true;
				isMovingDown = false;
			}
			else if(verticalDirection == VERTICAL_DOWN)
			{
				isMovingUp = false;
				isMovingDown = true;
			}
			else if(verticalDirection == VERTICAL_RANDOMIZED)
			{
				isMovingUp = (Math.random()>0.5);
				isMovingDown = !isMovingUp;
			}
			else if(verticalDirection == VERTICAL_NONE)
			{
				isMovingUp = false;
				isMovingDown = false;
			}
			
			/**Horizontal initial direction**/
			if(horizontalDirection == HORIZONTAL_LEFT)
			{
				isMovingLeft = true;
				isMovingRight = false;
			}
			else if(horizontalDirection == HORIZONTAL_RIGHT)
			{
				isMovingLeft = false;
				isMovingRight = true;
			}
			else if(horizontalDirection == HORIZONTAL_RANDOMIZED)
			{
				isMovingLeft = (Math.random()>0.5);
				isMovingRight = !isMovingLeft;
			}
			else if(horizontalDirection == HORIZONTAL_NONE)
			{
				isMovingLeft = false;
				isMovingRight = false;
			}
		}
		
		public function draw(event:TimerEvent):void
		{
			//Clear all of sprite
			this.graphics.clear();
			
			//Drawing part of the shape up to variable limit
			for(var i:int = 0; i < numberOfLinesShown; i++)
			{
				/**Set Line Style**/
				//if color is same color as background
				if(lineColor != 0x101010)
				{
					
					this.graphics.lineStyle(lineThickness,lineColor,lineAlpha);
				}
				else
				{
					//randomize line
					this.graphics.lineStyle(lineThickness,Math.random()*0xffffff,lineAlpha);
				}
				
					//Move to current point
					this.graphics.moveTo(points[i].x, points[i].y);
					//Draw to next point
					this.graphics.lineTo(points[i+1].x, points[i+1].y);
			}
			
			for(var m:int = 0; m< drawSpeed; m++)
			{
				//Remove point from the front of the array...
				var shiftedPoint : Point = points.shift();
			
				//...and put it on the back
				points.push(shiftedPoint);
			}
		}
	
		/**MOVE FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function move(duration:Number):void
		{
			/**Horizontal Movement**/
			this.rotation += speedOfRotation;//rotate sprite by speedOfRotation degrees CLOCKWISE
						
			//Move Right or Left
			if(isMovingLeft)
			{
				this.x -= horizontalMoveSpeed;//move left
				
				//limit movement range from startingXCoordinate
				if(this.x == (xCoordinate - horizontalLimit))
				{
					//switch directions
					isMovingRight = true;
					isMovingLeft = false;
				}
				
			}
			else if(isMovingRight)
			{
				this.x += horizontalMoveSpeed;//move right
				
				//limit movement range from startingXCoordinate
				if(this.x == (xCoordinate + horizontalLimit) )
				{
					//switch directions
					isMovingRight = false;
					isMovingLeft = true;
				}
				
			}
			
			/**Vertical Movement**/
			
			//Move Up or Down
			if(isMovingUp)
			{
				this.y -= verticalMoveSpeed;//move left
				
				//limit movement range from startingXCoordinate
				if(this.y == (yCoordinate - verticalLimit))
				{
					//switch directions
					isMovingDown = true;
					isMovingUp = false;
				}
				
			}
			else if(isMovingDown)
			{
				this.y += verticalMoveSpeed;//move right
				
				//limit movement range from startingXCoordinate
				if(this.y == (yCoordinate + verticalLimit) )
				{
					//switch directions
					isMovingDown = false;
					isMovingUp = true;
				}
				
			}
		}
		
		/**getX FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getX():int
		{
	
			
			return this.x;
		}
		
		/**getY FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getY():int
		{
			return this.y;
		}
		
		public function getObjectType():String
		{
			return "BaseVector";
		}
		
		
	}//end class
}//end package