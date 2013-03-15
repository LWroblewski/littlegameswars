package com.littlegames.framework.stage
{
  import com.littlegames.framework.entities.player.Player;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.utils.Global;

  public class ScreenBattle extends BaseScreen
  {
    override protected function onEnterFrame():void
    {
      for each (var player:Player in Global.players)
      {
        for each (var unit:UnitInstance in player.units)
        {
          //Rendu des unités de chaque joueur.
          unit.render();
        }
      }
    }
  }
}