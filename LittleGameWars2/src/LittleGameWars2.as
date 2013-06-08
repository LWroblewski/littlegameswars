package
{
  import com.gamewars.GameWarsRoot;
  
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  
  import starling.core.Starling;
  
  [SWF(width = "1024", height = "768", frameRate = "60", backgroundColor="#000000")]
  public class LittleGameWars2 extends Sprite
  {
    /** Réference vers Starling */
    private var mStarling:Starling;
    
    public function LittleGameWars2()
    {
      // These settings are recommended to avoid problems with touch handling
      stage.scaleMode = StageScaleMode.EXACT_FIT;
      stage.align = StageAlign.TOP_LEFT;
      
      // Initialisation de Starling
      mStarling = new Starling(GameWarsRoot, stage);
      mStarling.start();
      
      Starling.current.showStats = true;
    }
  }
}