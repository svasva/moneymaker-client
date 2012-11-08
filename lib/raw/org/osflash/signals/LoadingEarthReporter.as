package org.osflash.signals
{
	public interface LoadingEarthReporter
	{
		function get bedFoundAt():ISignal;
		function get possessionIdLoaded():ISignal;
		function get possessionAgeLoaded():ISignal;
		function get sproutFoundAt():ISignal;
		function get andItsIndexIs():ISignal;
	}
}
