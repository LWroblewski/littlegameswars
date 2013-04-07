package com.littlegames.framework.core.action
{
  public class GameActionResult
  {
    /** Resultats de traitement d'action */
    public static const SUCCESSFUL : String = 'SUCCESSFUL';
    public static const ERROR : String = 'FAIL';
    
    /** L'action liée au résultat */
    public var action:GameAction;
    /** Resultat du traitement de l'action */
    public var actionResult:Boolean;
    /** Message d'erreur lors d'un echec de traitement d'action */
    public var errorMessage:String;
    
    /** Resultat d'une action */
    public function GameActionResult(pAction:GameAction, pResult:Boolean, pErrorMessage:String = null)
    {
      action = pAction;
      actionResult = pResult;
      errorMessage = pErrorMessage;
    }
  }
}