package com.littlegames.framework.entities.building
{
	import com.littlegames.framework.entities.unit.Unit;
	
	/**
	 * Bâtiment permettant la production d'unités.
	 */
	public class Factory extends Building
	{
		/**
		 * Unités produites par le bâtiment.
		 */
		protected var _productedUnits:Vector.<Unit>;
		
		public function Factory()
		{
			super();
		}
	}
}