package com.littlegames.framework.core.engine.logic
{
  import com.littlegames.framework.core.action.GameAction;
  import com.littlegames.framework.core.action.GameActionResult;
  import com.littlegames.framework.core.data.GameData;

  public class LogicEngine
  {
    /** Réference vers les données du jeu */
    private var _gameData:GameData;
    /** Liste des actions en attente */
    private var _listPendingActions:Vector.<GameAction> = new <GameAction>[];
    /** Liste des resultats en attente */
    private var _listPendingResult:Vector.<GameActionResult> = new <GameActionResult>[];
    
    /** Constructeur */
    public function LogicEngine() {}
    
    /** Initialisation du moteur de logique */
    public function initializeGame(pGameData:GameData) : void
    {
      // TODO
      _gameData = pGameData;
    }
    
    /** Maj de la logique */
    public function update() : void
    {
      while (hasPendingActions())
      {
        var action:GameAction = pickAction();
        var result:GameActionResult = processAction(action);
        pushResult(result);
      }
    }
    
    /** Traitement d'une action */
    private function processAction(pAction:GameAction) : GameActionResult
    {
      var result:GameActionResult;
      
      switch (pAction.actionType)
      {
        // Mouvement
        // ------------------------------------------------------------------------
        case GameAction.ACTION_MOVE:
          result = processMove(pAction);
          break;
        // Attaque
        // ------------------------------------------------------------------------
        case GameAction.ACTION_ATTACK:
          result = processAttack(pAction);
          break;
        // Capture d'un batiment
        // ------------------------------------------------------------------------
        case GameAction.ACTION_CAPTURE:
          result = processCapture(pAction);
          break;
        // ------------------------------------------------------------------------
        default:
          result = new GameActionResult(pAction, false, "Invalid GameAction");
      }
      
      return result;
    }
    
    /** Traitement d'un déplacement */
    private function processMove(pAction:GameAction) : GameActionResult
    {
      // TODO
      return null;
    }
    
    private function processCapture(pAction:GameAction) : GameActionResult
    {
      // TODO
      return null;
    }
    
    /** Traitement d'une attaque */
    private function processAttack(pAction:GameAction) : GameActionResult
    {
      // TODO
      return null;
    }

    /** Récupère la prochaine action en attente */
    private function pickAction() : GameAction
    {
      return hasPendingActions()?_listPendingActions.shift():null;
    }
    
    /** Vérifie si des actions sont en attente de traitement */
    private function hasPendingActions() : Boolean
    {
      return _listPendingActions.length > 0;
    }
    
    /** Ajoute une action à la liste de traitements */
    public function pushAction(pAction:GameAction) : void
    {
      _listPendingActions.push(pAction);
    }
    
    
    /** Retire un résultat de la liste des resultats en attente */
    public function popResult() : GameActionResult
    {
      return hasPendingResults()?_listPendingResult.shift():null;
    }
    
    /** Il y a t-il des resultats en attente ? */
    public function hasPendingResults() : Boolean
    {
      return _listPendingResult.length > 0;
    }
    
    /** Ajoute un resultat de traitement d'action dans la file */
    private function pushResult(pResult:GameActionResult) : void
    {
      _listPendingResult.push(pResult);
    }
  }
}