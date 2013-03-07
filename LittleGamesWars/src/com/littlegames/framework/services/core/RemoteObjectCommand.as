package com.littlegames.framework.services.core
{
  import mx.rpc.AbstractOperation;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;
  import mx.rpc.remoting.RemoteObject;

  import starling.events.EventDispatcher;

  /**
   * Commande de base d'appel de service PHP.
   */
  public class RemoteObjectCommand extends EventDispatcher
  {
    /**
     * Destination du service (cf services-config.xml).
     */
    private static var _DESTINATION:String = 'amfphp';

    /**
     * RemoteObject de la connection.
     */
    private var _connexion:RemoteObject;

    /**
     * Nom du service à appeller.
     */
    private var _service:String;

    /**
     * Méthode du service à appeller.
     */
    private var _operation:String;

    /**
     * Paramètres à passer à la méthode du service.
     */
    private var _parameters:Object;

    /**
     * Fonction appellée à la fin du service.
     */
    private var _callback:Function;

    /**
     * Constructeur.
     *
     * @param pService String Nom du service.
     * @param pOperation String Nom de la méthode.
     * @param pParameters Object Paramètre de la méthode (si un seul).
     * @param pCallback Function Fonction de callback.
     */
    public function RemoteObjectCommand(pService:String, pOperation:String, pParameters:Object = null, pCallback:Function = null)
    {
      _service = pService;
      _operation = pOperation;
      _parameters = pParameters;
      _callback = pCallback;

      super();
    }

    /**
     * Exécution de la commande.
     */
    protected function execute():void
    {
      _connexion = new RemoteObject(_DESTINATION);
      _connexion.source = _service;
      _connexion.addEventListener(ResultEvent.RESULT, resultHandler);
      _connexion.addEventListener(FaultEvent.FAULT, faultHandler);
      _execute(_connexion.getOperation(_operation));
    }

    /**
     * A surcharger pour définir plus d'un paramètre à l'opération.
     *
     * ex : pOperation.send(param1, param2);
     */
    protected function _execute(pOperation:AbstractOperation):void
    {
      pOperation.send(_parameters);
    }

    protected function resultHandler(pEvent:ResultEvent):void
    {
      finish();

      if (_callback != null)
      {
        _callback(pEvent.result);
      }

      dispatchEvent(new CommandEvent(CommandEvent.FINISH, pEvent.result));
    }

    protected function faultHandler(pEvent:FaultEvent):void
    {
      cancel();

      dispatchEvent(new CommandEvent(CommandEvent.CANCELED, pEvent.fault));
    }

    /**
     * Fin de la commande.
     */
    protected function finish():void
    {
      deleteConnexion();
    }

    /**
     * Echec de la commande.
     */
    protected function cancel():void
    {
      deleteConnexion();
    }

    /**
     * Suppression des écouteurs sur la commande.
     */
    protected function deleteConnexion():void
    {
      _connexion.removeEventListener(ResultEvent.RESULT, resultHandler);
      _connexion.removeEventListener(FaultEvent.FAULT, faultHandler);
    }
  }
}