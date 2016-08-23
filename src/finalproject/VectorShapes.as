package finalproject
{
	public class VectorShapes
	{
		import flash.geom.Point;
		
		/**Rectangle**/
		public var rectangleLoop    		 : Vector.<Point>;
		public var rectangleReverseLoop      : Vector.<Point>;
		
		/**Head**/
		public var headLoop         		 : Vector.<Point>;
		public var headReverseLoop  		 : Vector.<Point>;
		
		/**Line**/
		public var lineBack        		     : Vector.<Point>;
		public var lineStart				 : Vector.<Point>;
		
		public var borderLine				:Vector.<Point>;
		
		/**Spiral**/
		public var spiralStart			     : Vector.<Point>;
		public var circleLoop                : Vector.<Point>;
		public var smallCircleLoop           : Vector.<Point>;
		public var smallCircleReverseLoop    : Vector.<Point>;

		/**Spikes**/
		public var spikesStart				 : Vector.<Point>;
		public var spikesBack				 : Vector.<Point>;
		public var spikesReverseBack		 : Vector.<Point>;
		
		/**Stairs**/
		public var stairsStart               : Vector.<Point>;
		public var stairsLoop				 : Vector.<Point>;
		public var stairsReverseLoop		 : Vector.<Point>;
		public var stairsBack				 : Vector.<Point>;
		public var stairsReverseBack		 :Vector.<Point>;
	 
		/**Numbers**/
		public var oneLoop               : Vector.<Point>;
		public var oneReverseLoop               : Vector.<Point>;

		public var twoLoop               : Vector.<Point>;
		public var twoReverseLoop               : Vector.<Point>;



		
		/**Constants used to draw lines**/
		protected const HORIZONTAL			 : int = 0;
		protected const VERTICAL   			 : int = 1;
		protected const DIAGONAL   			 : int = 2;
		protected const CURVE	   			 : int = 3;
		protected const DISAPPEAR  			 : int = 4;


		
		public function VectorShapes()
		{
			
			/**Rectangle Loop Data**/
			//Fill Member Variable
			rectangleLoop = new Vector.<Point>(25);
			//Top
			increasingLine(rectangleLoop, 0, 9,-50,-10, HORIZONTAL);
			//Right Down
			increasingLine(rectangleLoop,10,12, 50,-10, VERTICAL);
			//Bottom
			decreasingLine(rectangleLoop,13,21, 40, 10, HORIZONTAL);
			//Left Up
			decreasingLine(rectangleLoop,22,24,-50, 10, VERTICAL);
			
			
			/**Rectangle Reverse Loop Data**/
			rectangleReverseLoop = rectangleLoop.slice();
			rectangleReverseLoop = rectangleReverseLoop.reverse();
			
			
			/**Head Loop Data**/
			//Fill Member Variable
			headLoop = new Vector.<Point>(18);
			//Top
			increasingLine(headLoop, 0, 4,-20,-20, HORIZONTAL);
			//Right Down
			increasingLine(headLoop,5,9,20,-20, VERTICAL);
			//Bottom
			decreasingLine(headLoop,10,13, 20, 20, HORIZONTAL);
			//Left Up
			decreasingLine(headLoop,14,17,-20, 20, VERTICAL);
			
			
			/**Head Reverse Loop Data**/
			headReverseLoop = headLoop.slice();
			headReverseLoop = headReverseLoop.reverse();
			
						
			/**Line Back Data**/
			//Fill Member Variable
			lineBack = new Vector.<Point>(54);
			//Forward Line
			increasingLine(lineBack,0,20,-100,0,HORIZONTAL);
			//Disappear
			increasingLine(lineBack,21,26,100,0,DISAPPEAR);
			//Backward Line
			decreasingLine(lineBack,27,47,100,0,HORIZONTAL);
			//Disappear
			decreasingLine(lineBack,48,53,-100,0,DISAPPEAR);
			
			
			/**Line Start Data**/
			//Fill Member Variable
			lineStart = new Vector.<Point>(28);
			//Line
			increasingLine(lineStart,0,20,-100,0,HORIZONTAL)
			//Disappear
			increasingLine(lineStart,21,26,100,0,DISAPPEAR);
			//End
			lineStart[27] = null;
		
			/**Border Line Data**/
			borderLine = new Vector.<Point>(2);
			
			increasingLine(borderLine, 0, 1, 0,0,HORIZONTAL, 2000);
			
			/**Spiral Start Data**/			
			spiralStart = new Vector.<Point>(214);
			//initial delay
			decreasingLine(spiralStart, 0, 50, 50, 50, DISAPPEAR);			
			//curve
			decreasingLine(spiralStart, 51, 161, 50, 50, CURVE, 10, 10, 25);			
			//end disappear
			decreasingLine(spiralStart, 162, 212, 0, 0, DISAPPEAR);			
			spiralStart[213] = null;
			
			/**Spikes Start Data**/
			//Fill Member Variable
			spikesStart = new Vector.<Point>(69);
			//Initial Disappear
			increasingLine(spikesStart,0,15,0,0,DISAPPEAR);
			//Spike
			increasingLine(spikesStart,16,18,0,0,DIAGONAL);
			increasingLine(spikesStart,19,21,30,30,DIAGONAL,10,-10);
			//Spike
			increasingLine(spikesStart,22,24,60,0,DIAGONAL);
			increasingLine(spikesStart,25,27,90,30,DIAGONAL,10,-10);
			//Spike
			increasingLine(spikesStart,28,30,120,0,DIAGONAL);
			increasingLine(spikesStart,31,33,150,30,DIAGONAL,10,-10);
			//Spike
			increasingLine(spikesStart,34,36,180,0,DIAGONAL);
			increasingLine(spikesStart,37,39,210,30,DIAGONAL,10,-10);
			//Spike
			increasingLine(spikesStart,40,42,240,0,DIAGONAL);
			increasingLine(spikesStart,43,45,270,30,DIAGONAL,10,-10);
			//Spike
			increasingLine(spikesStart,46,48,300,0,DIAGONAL);
			increasingLine(spikesStart,49,51,330,30,DIAGONAL,10,-10);
			//End Disappear
			increasingLine(spikesStart,52,67,360,0,DISAPPEAR);
			//End
			spikesStart[68] = null;
			
			/**Spikes Back Data**/
			//Fill Member Variable
			spikesBack = new Vector.<Point>(104);
			//Initial Disappear
			increasingLine(spikesBack,0,15,0,0,DISAPPEAR);
			//Spike 1
			increasingLine(spikesBack,16,18,0,0,DIAGONAL);
			increasingLine(spikesBack,19,21,30,30,DIAGONAL,10,-10);
			//Spike 2
			increasingLine(spikesBack,22,24,60,0,DIAGONAL);
			increasingLine(spikesBack,25,27,90,30,DIAGONAL,10,-10);
			//Spike 3
			increasingLine(spikesBack,28,30,120,0,DIAGONAL);
			increasingLine(spikesBack,31,33,150,30,DIAGONAL,10,-10);
			//Spike 4
			increasingLine(spikesBack,34,36,180,0,DIAGONAL);
			increasingLine(spikesBack,37,39,210,30,DIAGONAL,10,-10);
			//Spike 5
			increasingLine(spikesBack,40,42,240,0,DIAGONAL);
			increasingLine(spikesBack,43,45,270,30,DIAGONAL,10,-10);
			//Spike 6
			increasingLine(spikesBack,46,48,300,0,DIAGONAL);
			increasingLine(spikesBack,49,51,330,30,DIAGONAL,10,-10);
			//End Disappear
			increasingLine(spikesBack,52,67,360,0,DISAPPEAR);
			//Spike 6 Back
			decreasingLine(spikesBack,68,70,360,0,DIAGONAL, 10, -10);
			decreasingLine(spikesBack,71,73,330,30,DIAGONAL,10,10);
			//Spike 5 Back
			decreasingLine(spikesBack,74,76,300,0,DIAGONAL, 10, -10);
			decreasingLine(spikesBack,77,79,270,30,DIAGONAL,10,10);
			//Spike 4 Back
			decreasingLine(spikesBack,80,82,240,0,DIAGONAL, 10, -10);
			decreasingLine(spikesBack,83,85,210,30,DIAGONAL,10,10);
			//Spike 3 Back
			decreasingLine(spikesBack,86,88,180,0,DIAGONAL, 10, -10);
			decreasingLine(spikesBack,89,91,150,30,DIAGONAL,10,10);
			//Spike 2 Back
			decreasingLine(spikesBack,92,94,120,0,DIAGONAL, 10, -10);
			decreasingLine(spikesBack,95,97,90,30,DIAGONAL,10,10);
			//Spike 1
			decreasingLine(spikesBack,98,100,60,0,DIAGONAL, 10, -10);
			decreasingLine(spikesBack,101,103,30,30,DIAGONAL,10,10);
			
			/**Spikes Reverse Back Data**/
			spikesReverseBack = spikesBack.slice();
			spikesReverseBack = spikesReverseBack.reverse();
			
			/**Stairs Start Data**/
			//Fill Member Variable
			stairsStart = new Vector.<Point>(73);
			//Initial Disappear
			increasingLine(stairsStart,0,15,0,0,DISAPPEAR);			
			//Stair
			decreasingLine(stairsStart,16,19,0,0,VERTICAL);
			increasingLine(stairsStart,20,23,0,-30,HORIZONTAL);
			//Stair
			decreasingLine(stairsStart,24,27,30,-30,VERTICAL);
			increasingLine(stairsStart,28,31,30,-60,HORIZONTAL);
			//Stair
			decreasingLine(stairsStart,32,35,60,-60,VERTICAL);
			increasingLine(stairsStart,36,39,60,-90,HORIZONTAL);
			//Stair
			decreasingLine(stairsStart,40,43,90,-90,VERTICAL);
			increasingLine(stairsStart,44,47,90,-120,HORIZONTAL);
			//Stair
			decreasingLine(stairsStart,48,51,120,-120,VERTICAL);
			increasingLine(stairsStart,52,55,120,-150,HORIZONTAL);
			//End Disappear
			increasingLine(stairsStart,56,71,150,-150,DISAPPEAR);
			//End
			stairsStart[72] = null;		
			
			/**Stairs Loop Data**/
			stairsLoop = new Vector.<Point>(72);
			
			//Stair Step 1
			decreasingLine(stairsLoop,0,3,0,0,VERTICAL);
			increasingLine(stairsLoop,4,7,0,-30,HORIZONTAL);
			//Stair Step 2
			decreasingLine(stairsLoop,8,11,30,-30,VERTICAL);
			increasingLine(stairsLoop,12,15,30,-60,HORIZONTAL);
			//Stair Step 3
			decreasingLine(stairsLoop,16,19,60,-60,VERTICAL);
			increasingLine(stairsLoop,20,23,60,-90,HORIZONTAL);
			//Stair Step 4
			decreasingLine(stairsLoop,24,27,90,-90,VERTICAL);
			increasingLine(stairsLoop,28,31,90,-120,HORIZONTAL);
			//Stair Step 5
			decreasingLine(stairsLoop,32,35,120,-120,VERTICAL);
			increasingLine(stairsLoop,36,39,120,-150,HORIZONTAL);
			//Vertical Line Down
			increasingLine(stairsLoop, 40, 55, 150, -150, VERTICAL);
			//Horizontal Line Over
			decreasingLine(stairsLoop, 56, 71, 150, 0, HORIZONTAL);
			
			/**Stairs Reverse Loop Data**/
			stairsReverseLoop = stairsLoop.slice();
			stairsReverseLoop = stairsReverseLoop.reverse();
			
			/**Stairs Back Data**/
			//Fill Member Variable
			stairsBack = new Vector.<Point>(110);
			
			//Stair Step 1
			decreasingLine(stairsBack,0,3,0,0,VERTICAL);
			increasingLine(stairsBack,4,7,0,-30,HORIZONTAL);
			//Stair Step 2
			decreasingLine(stairsBack,8,11,30,-30,VERTICAL);
			increasingLine(stairsBack,12,15,30,-60,HORIZONTAL);
			//Stair Step 3
			decreasingLine(stairsBack,16,19,60,-60,VERTICAL);
			increasingLine(stairsBack,20,23,60,-90,HORIZONTAL);
			//Stair Step 4
			decreasingLine(stairsBack,24,27,90,-90,VERTICAL);
			increasingLine(stairsBack,28,31,90,-120,HORIZONTAL);
			//Stair Step 5
			decreasingLine(stairsBack,32,35,120,-120,VERTICAL);
			increasingLine(stairsBack,36,39,120,-150,HORIZONTAL);
			//End Disappear
			increasingLine(stairsBack,40,55,150,-150,DISAPPEAR);
			//Stair Step 5 Back
			decreasingLine(stairsBack,56,59,150,-150,HORIZONTAL);
			increasingLine(stairsBack,60,63,120,-150,VERTICAL);
			//Stair Step 4 Back
			decreasingLine(stairsBack,64,67,120,-120,HORIZONTAL);
			increasingLine(stairsBack,68,71,90,-120,VERTICAL);
			//Stair Step 3 Back
			decreasingLine(stairsBack,72,75,90,-90,HORIZONTAL);
			increasingLine(stairsBack,76,79,60,-90,VERTICAL);
			//Stair Step 2 Back
			decreasingLine(stairsBack,80,81,60,-60,HORIZONTAL);
			increasingLine(stairsBack,82,85,30,-60,VERTICAL);
			//Stair Step 1 Back
			decreasingLine(stairsBack,86,89,30,-30,HORIZONTAL);
			increasingLine(stairsBack,90,93,0,-30,VERTICAL);
			//Disappear
			increasingLine(stairsBack,94,109,0,0,DISAPPEAR);
			
			/**Stairs Reverse Back Data**/
			stairsReverseBack = stairsBack.slice();
			stairsReverseBack = stairsReverseBack.reverse();
			
			/**Circle Loop Data**/
			circleLoop = new Vector.<Point>(40);
			increasingLine(circleLoop,0,39,-100,-100,CURVE,10,10,7);
			
			/**Small Circle Loop Data**/
			smallCircleLoop = new Vector.<Point>(20);
			increasingLine(smallCircleLoop,0,19,-100,-100,CURVE,10,10,18);

			/**Small Circle Reverse Loop Data**/
			smallCircleReverseLoop = smallCircleLoop.slice();
			smallCircleReverseLoop = smallCircleReverseLoop.reverse();

			
			/**One Loop Data**/
			//Fill Member Variable
			oneLoop = new Vector.<Point>(36);
			
			//Top
			increasingLine(oneLoop,0,2,0,0,HORIZONTAL);
			//Right side
			increasingLine(oneLoop,3,13,20,0,VERTICAL);
			//Bottom
			decreasingLine(oneLoop,14,16,20,100,HORIZONTAL);
			//Bottom Left
			decreasingLine(oneLoop,17,23,0,100,VERTICAL);
			//Bulge bottom
			decreasingLine(oneLoop,24,26,0,40,HORIZONTAL);
			//Bulge Left
			decreasingLine(oneLoop,27,29,-20,40,VERTICAL);
			//Bulge Top
			increasingLine(oneLoop,30,32,-20,20,HORIZONTAL);
			//Back
			decreasingLine(oneLoop,33,35,0,20,VERTICAL);
			
			/**One Reverse Loop Data**/
			oneReverseLoop = oneLoop.slice();
			oneReverseLoop = oneReverseLoop.reverse();
			
			/**Two Loop Data**/
			//Fill Member Variable
			twoLoop = new Vector.<Point>(83);
			
			//Top
			increasingLine(twoLoop,0,8,0,0,HORIZONTAL);
			//Right top side
			increasingLine(twoLoop,9,11,80,0,VERTICAL);
			//right top
			increasingLine(twoLoop,12,14,80,20,HORIZONTAL);
			//right right
			increasingLine(twoLoop,15,19,100,20,VERTICAL);
			//middle bottom
			decreasingLine(twoLoop,20,28,100,60,HORIZONTAL);
			//middle Left right
			increasingLine(twoLoop,29,31,20,60,VERTICAL);
			//Bottom Top
			increasingLine(twoLoop,32,40,20,80,HORIZONTAL);
			//Bottom right
			decreasingLine(twoLoop,41,43,100,80,VERTICAL);
			//Bottom bottom
			decreasingLine(twoLoop,41,51,100,100,HORIZONTAL);
			//left bottom
			decreasingLine(twoLoop,52,58,0,100,VERTICAL);
			//middle top
			increasingLine(twoLoop,59,67,0,40,	HORIZONTAL);
			//right top left
			decreasingLine(twoLoop,68,70,80,40,	VERTICAL);
			//Bottom top
			decreasingLine(twoLoop,71,79,80,20,HORIZONTAL);
			//top left
			decreasingLine(twoLoop,80,82,0,20,	VERTICAL);
			
			
			/**Two Reverse Loop Data**/
			twoReverseLoop = twoLoop.slice();
			twoReverseLoop = twoReverseLoop.reverse();
		}
		
		/**For loop function changes, initial index name, beginning index, ending index, 
		 * beginning point x, beginning point y, draw type, diagonal x degree, 
		 * diagonal y degree, degrees to rotate for curve**/
		private function increasingLine(array					: Vector.<Point>,
										index					: int, 
										endingIndex				: int, 
										beginningXCoordinate	: int, 
										beginningYCoordinate	: int, 
										drawType				: int, 
										XScalar			: int = 10, 
										YScalar			: int = 10,
										degreesToRotate			: Number = 0):void
		{
			var counter : Number = 0;

			if(drawType ==0)
			{
				//horizontal
				for(var i: int = index; i <= endingIndex; i++)
				{
					array[i] = new Point(beginningXCoordinate + (XScalar*counter), beginningYCoordinate );
					counter++;
				}
			}
			else if(drawType == 1)
			{
				//vertical
				for(var j: int = index; j <= endingIndex; j++)
				{
					array[j] = new Point(beginningXCoordinate, beginningYCoordinate + (YScalar*counter) );
					counter++;
				}
			}
			else if(drawType == 2)
			{
				//diagonal
				for(var k: int = index; k <= endingIndex; k++)
				{
					array[k] = new Point(beginningXCoordinate + (XScalar*counter), beginningYCoordinate + (YScalar*counter) );
					counter++;
				}
			}
			else if(drawType == 3)
			{
				//curvy
				for(var l: int = index; l <= endingIndex; l++)
				{
					array[l] = createCurvePoint(beginningXCoordinate, beginningYCoordinate, degreesToRotate);
					
					beginningXCoordinate = array[l].x;
					beginningYCoordinate = array[l].y;
				}
			}
			else if(drawType == 4)
			{
				//disappear
				for(var m: int = index; m <= endingIndex; m++)
				{
					array[m] = new Point(beginningXCoordinate, beginningYCoordinate);
				}
			}
		}
		
		/**Like increasing line function but moves left**/
		private function decreasingLine(array					: Vector.<Point>,
										index					: int, 
										endingIndex				: int, 
										beginningXCoordinate	: int, 
										beginningYCoordinate	: int, 
										drawType				: int, 
										XScalar			: int = 10, 
										YScalar			: int = 10,
										degreesToRotate			: Number = 0):void
		{
			var counter: Number = 0;
			
			if(drawType ==0)
			{
				//horizontal
				for(var i: int = index; i <= endingIndex; i++)
				{
					array[i] = new Point(beginningXCoordinate - (XScalar*counter), beginningYCoordinate );
					counter++;
				}
			}
			else if(drawType == 1)
			{
				//vertical
				for(var j: int = index; j <= endingIndex; j++)
				{
					array[j] = new Point(beginningXCoordinate, beginningYCoordinate - (YScalar*counter) );
					counter++;
				}
			}
			else if(drawType == 2)
			{
				//diagonal
				for(var k: int = index; k <= endingIndex; k++)
				{
					array[k] = new Point(beginningXCoordinate - (XScalar*counter), beginningYCoordinate - (YScalar*counter) );
					counter++;
				}
			}
			else if(drawType == 3)
			{
				//curvy
				for(var l: int = index; l <= endingIndex; l++)
				{
					array[l] = createCurvePoint(beginningXCoordinate, beginningYCoordinate, -degreesToRotate);
					
					beginningXCoordinate = array[l].x;
					beginningYCoordinate = array[l].y;
				}
			}
			else if(drawType == 4)
			{
				//disappear
				for(var m: int = index; m <= endingIndex; m++)
				{
					array[m] = new Point(beginningXCoordinate, beginningYCoordinate);
				}
			}
		}
		

		public function
			createCurvePoint(begX: int, begY: int, degrees : Number ) : Point
		{
			//new point with starting vars...
			var tempPoint:Point = new Point(begX, begY);

			var radians:Number = GeometricVector.degrees_to_radians( -degrees );
			
			//...calc. new vars for temp 
			// WARNING: Must compute new_x and new_y before modifying this.x or this.y.
			var new_x:Number = Math.cos( radians )* tempPoint.x - Math.sin( radians ) * tempPoint.y;
			var new_y:Number = Math.sin( radians )* tempPoint.x + Math.cos( radians ) * tempPoint.y;
			
			//...put into temp point
			tempPoint.x = new_x;
			tempPoint.y = new_y;
			
			//...return
			return tempPoint;
		}
		
		
	}
}