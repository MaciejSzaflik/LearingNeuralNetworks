package nobody;

import js.Lib;

/**
 * ...
 * @author 
 */
class Main 
{
	
	static function main() 
	{
		var hamster = new HamsterNetwork();
		hamster.retrain();
		var result = hamster.getOutput([1, 0]);
		trace("Sit neuron: " + result[0] * 100);
		trace("Run neuron: " + result[1] * 100);
		trace("Jump neuron: " + result[2] * 100);
		
		
		/*var temperature = new TemperatureNetwork();
		temperature.train();
		
		temperature.getOutput(11);
		temperature.getOutput(32);
		temperature.getOutput(5);*/
		
		var xorNet = new XorNetwork();
		xorNet.train();
		
		xorNet.getOutput([0.0, 0.0]);
		xorNet.getOutput([1.0, 0.0]);
		xorNet.getOutput([0.0, 1.0]);
		xorNet.getOutput([1.0, 1.0]);
	}
}