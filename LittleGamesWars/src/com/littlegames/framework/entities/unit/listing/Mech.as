package com.littlegames.framework.entities.unit.listing
{
	import com.littlegames.framework.entities.unit.MovementType;
	import com.littlegames.framework.entities.unit.BaseUnit;
	import com.littlegames.framework.entities.unit.weapon.listing.Bazooka;
	import com.littlegames.framework.entities.unit.weapon.listing.MachineGun;
	
	/**
	 * Infanterie lourde, équipée d'un bazooka.
	 */
	public class Mech extends BaseUnit
	{
		public static const ID:String = "mech";
		
		public function Mech()
		{
			super("Mech", 3000, 300, 2, MovementType.INFANTRY, 2, 70, new MachineGun(), new Bazooka());
		}
	}
}