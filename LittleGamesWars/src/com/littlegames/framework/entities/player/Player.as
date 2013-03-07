package com.littlegames.framework.entities.player
{
	import com.littlegames.framework.entities.co.Commander;
	import com.littlegames.framework.entities.unit.UnitInstance;
	
	/**
	 * Joueur.
	 */
	public class Player
	{
		/**
		 * Commandant choisi par le joueur.
		 */
		protected var _co:Commander;
		
		/**
		 * Liste des unités du joueur.
		 */
		protected var _units:Vector.<UnitInstance>;
		
		/**
		 * Argent du joueur.
		 */
		protected var _gold:uint;
		
		public function Player()
		{
		}
	}
}