package org.osflash.signals
{
	public interface AsyncRequester
	{
		function get require():ISignal;
		function get replied():ISignal;
	}
}
