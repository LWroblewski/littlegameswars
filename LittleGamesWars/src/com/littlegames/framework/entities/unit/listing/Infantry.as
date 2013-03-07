package com.littlegames.framework.entities.unit.listing
{
	import com.littlegames.framework.entities.unit.MovementType;
	import com.littlegames.framework.entities.unit.Unit;
	import com.littlegames.framework.entities.unit.weapon.listing.MachineGun;
	
	/**
	 * Infanterie (unité de base).
	 */
	public class Infantry extends Unit
	{
		public static const ID:String = "Infantry";
		
    /** Vitesse de capture des bâtiments par défaut. */
    public static const DEFAULT_CAPTURE_SPEED:uint = 5;
    
    /** Vitesse de capture des bâtiments par une infanterie. */
    protected var _captureSpeed:uint;
    
		public function Infantry()
		{
			super("Infanterie", 1000, 100, 3, MovementType.INFANTRY, 2, 99, new MachineGun());
      
      _captureSpeed = DEFAULT_CAPTURE_SPEED;
		}
	}
}