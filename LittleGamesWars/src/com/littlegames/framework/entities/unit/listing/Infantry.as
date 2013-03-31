package com.littlegames.framework.entities.unit.listing
{
	import com.littlegames.framework.entities.unit.MovementType;
	import com.littlegames.framework.entities.unit.BaseUnit;
	import com.littlegames.framework.entities.unit.weapon.listing.MachineGun;
	
	/** Infanterie (unité de base). */
	public class Infantry extends BaseUnit
	{
    /** Vitesse de capture des bâtiments par défaut. */
    public static const DEFAULT_CAPTURE_SPEED:uint = 5;
    // ------------------------------------------------------------------------
    /** Vitesse de capture des bâtiments par une infanterie. */
    protected var _captureSpeed:uint;
    
		public function Infantry()
		{
      unitId = 0;
			super("Infanterie", 1000, 100, 3, MovementType.INFANTRY, 2, 99, new MachineGun());
      
      _captureSpeed = DEFAULT_CAPTURE_SPEED;
		}
	}
}