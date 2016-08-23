/**
 * 
 * File:		Collider.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu) & Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-25-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 * 				Collider interface contains collide() and getNormal().
 * 
 **/
package finalproject
{
	import flash.display.Sprite;
	
	//ALL COLLIDERS MUST HAVE A COLLIDE AND GET NORMAL FUNCTION!!!
	public interface Collider
	{
		//check if another object is overlapping (collision)
		//function collide(otherObject: Sprite):Boolean;
		
		//return normal on collision
		//function getNormal():GeometricVector;
	}
}