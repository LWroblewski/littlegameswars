package com.littlegames.framework.entities.co.listing
{
	import com.littlegames.framework.entities.co.Commander;
	import com.littlegames.framework.resources.Portraits;
	import com.littlegames.framework.utils.HashMap;
	
	/**
	 * Commandant de base : pas de points forts ni de faiblesses.
	 */
	public class Andy extends Commander
	{
		public static const ID:String = "Andy";
		
		public function Andy()
		{
			super("Andy", new Repair(), 3);
		}
	}
}

import com.littlegames.framework.entities.co.Power;

class Repair extends Power
{
  public function Repair()
  {
    super("Réparation");
  }
}