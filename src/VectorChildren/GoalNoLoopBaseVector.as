package VectorChildren
{
	import finalproject.NoLoopBaseVector;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class GoalNoLoopBaseVector extends NoLoopBaseVector
	{
		public function GoalNoLoopBaseVector(world:Sprite, xCoordinateParameter:Number, yCoordinateParameter:Number, pointsParameter:Vector.<Point>, numberOfLinesShownParameter:int, drawSpeedParameter:int=1, lineThicknessParameter:Number=1, lineColorParameter:Number=0x00ff00, lineAlphaParameter:Number=1, scalarXParameter:Number=1, scalarYParameter:Number=1, initialRotationParameter:Number=0, horizontalMoveSpeedParameter:Number=1, horizontalLimitParameter:Number=100, horizontalDirectionParameter:int=-1, verticalMoveSpeedParameter:Number=1, verticalLimitParameter:Number=100, verticalDirectionParameter:int=-1, speedOfRotationParameter:Number=0)
		{
			super(world, xCoordinateParameter, yCoordinateParameter, pointsParameter, numberOfLinesShownParameter, drawSpeedParameter, lineThicknessParameter, lineColorParameter, lineAlphaParameter, scalarXParameter, scalarYParameter, initialRotationParameter, horizontalMoveSpeedParameter, horizontalLimitParameter, horizontalDirectionParameter, verticalMoveSpeedParameter, verticalLimitParameter, verticalDirectionParameter, speedOfRotationParameter);
		}
	}
}