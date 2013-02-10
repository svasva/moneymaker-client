package asst.api.mailru {
	
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.external.ExternalInterface;
import flash.utils.getQualifiedClassName;

[Event(name="complete", type="flash.events.Event")]

public class MailruCall	{
	
	static private var callbacks     : Object = {};
	static private var flashId       : String;
	static private var appPrivateKey : String;
	static private var dispatcher    : EventDispatcher;
	static private var isInited      : Boolean = false;
	
	static public function init ( DOMFlashId : String, privateKey : String ) : void {
		if ( isInited ) { throw Error ( 'MailruCall already initialized' ); return; }
		flashId = DOMFlashId;
		appPrivateKey = privateKey;
		dispatcher = new EventDispatcher();
		ExternalInterface.addCallback('mailruReceive', receiver);
		exec ( 'mailru.init', onApiLoaded, privateKey, flashId );
		isInited = true;
	}
	
	/** Если callback не указан, exec() попытается вернуть значение **/	
	static public function exec ( method : String, callback : Function = null, ...args ) : * {
		var cbid : int;
		if ( callback != null ) {
			cbid = Math.round ( Math.random() * int.MAX_VALUE );
			callbacks[cbid] = callback;
		}
		var objectName:String = (method.match(/(.*)\.[^.]+$/)||[0,'window'])[1];
		return ExternalInterface.call('' +
			'(function(args, cbid){ ' +  
			'if(typeof ' + method + ' != "function"){ ' +
			'	if(cbid) { document.getElementById("'+ flashId+ '").mailruReceive(cbid, ' + method + '); }' +
			'	else { return '+ method+ '; }' +
			'}' +  			
			'if(cbid) {' + 
			'	args.unshift(function(value){ ' + 
			'		document.getElementById("'+ flashId+ '").mailruReceive(cbid, value) ' +
			'	}); ' + 
			'};' + 
			'return '+ method+ '.apply('+ objectName+ ', args) ' + 
			'})', args, cbid);
	}
	
	static private function receiver ( cbid : Number, data : Object ) : void {
		if ( callbacks[cbid] ) {
			var cb : Function = callbacks[cbid];
			delete callbacks[cbid];
			cb.call ( null, data );
		}
	}
	
	static private function eventReceiver ( name : String, data : Object ) : void {
		trace ( 'eventReceiver: ' + arguments );
		dispatchEvent ( new MailruCallEvent ( name, data ) );
	}
	
	static private function onApiLoaded ( ...args ) : void {
		ExternalInterface.addCallback ( 'mailruEvent', eventReceiver );
		dispatchEvent ( new Event ( Event.COMPLETE ) );
	}
	
	/************************* EventDispatcher IMPLEMENTATION ****************************/
	
	static public function addEventListener ( type : String, listener : Function, priority : int = 0, useWeakReference : Boolean = false ) : void {
   		dispatcher.addEventListener ( type, listener, false, priority, useWeakReference );
	}
	
	static public function removeEventListener ( type : String, listener : Function ) : void {
		dispatcher.removeEventListener ( type, listener );
	}
	
	static public function hasEventListener ( type : String ) : Boolean {
		return dispatcher.hasEventListener ( type );
	}
	
	static public function dispatchEvent ( event : Event ) : void {
		dispatcher.dispatchEvent ( event );
	}
	
}}