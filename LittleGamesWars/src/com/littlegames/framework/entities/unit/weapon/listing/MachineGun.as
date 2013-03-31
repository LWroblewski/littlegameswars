package com.littlegames.framework.entities.unit.weapon.listing
{
	import flash.utils.Dictionary;
	
	import com.littlegames.framework.entities.unit.listing.Infantry;
	import com.littlegames.framework.entities.unit.listing.Mech;
	import com.littlegames.framework.entities.unit.weapon.Weapon;
	
	public class MachineGun extends Weapon
	{
		public function MachineGun()
		{
			super("Machine Gun");
		}
		
		override protected function getEfficiencies():Dictionary
		{
			var efficiencies:Dictionary = new Dictionary(true);
			//efficiencies[Infantry.ID] = 0.65;
			//efficiencies[Mech.ID] = 0.55;
			return efficiencies;
		}
	}
}