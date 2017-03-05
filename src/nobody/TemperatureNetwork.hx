package nobody;
import haxe.io.Bytes;
import moon.ai.neural.Trainer;
import moon.ai.neural.networks.PerceptronNetwork;
import thx.Tuple.Tuple2;

/**
 * ...
 * @author 
 */
class TemperatureNetwork
{
	var deepNetwork:PerceptronNetwork;
	var trainingData : Array <Tuple2<Array<Float>, Array<Float>>>;
	
	public function new() 
	{
		deepNetwork = new PerceptronNetwork([7, 3, 3, 4]);
		createTrainingData();
	}
	
	public function train()
	{
		var trainer = new Trainer(deepNetwork);
		
		var trainData = new TrainingSet();
		for (tuple in trainingData)
		{
			trainData.push({output : tuple._1, input : tuple._0});
		}
		
		trainer.train(trainData, {
		rate:0.1,iterations:10000,shuffle:true
		});
	}
	
	public function getOutput(inputData : Int)
	{
		var result = deepNetwork.activate(convertTemperatureToBinary(inputData));

		trace("For value: " + inputData);
		trace("THICK JACKET neuron: " + (result[0] * 100));
		trace("SWEATER neuron: " + (result[1] * 100));
		trace("T-SHIRT neuron: " + (result[2] * 100));
		trace("NOTHING neuron: " + (result[3] * 100));
	}
	
	private function createTrainingData()
	{
		trainingData = new  Array < Tuple2<Array<Float>, Array<Float>> > ();
		for (i in 0...50)
		{
			var input = convertTemperatureToBinary(i);
			var output = [0.0, 0.0, 0.0, 0.0];
			
			if (i <= 5)
				output = [1.0, 0.0, 0.0, 0.0];
			else if (i > 5 && i <= 15)
				output = [0.0, 1.0, 0.0, 0.0];
			else if (i > 15 && i <= 40)
				output = [0.0, 0.0, 1.0, 0.0];
			else
				output = [0.0, 0.0, 0.0, 1.0];
				
			trainingData.push(new Tuple2(input, output));
		}
	}
	
	private function convertTemperatureToBinary(value:Int) : Array<Float>
	{
		var array = new Array<Float>();
		var n:Dynamic = value;
		var binaryString:String = n.toString(2);
		
		if (binaryString.length > 7)
			return [0, 0, 0, 0, 0, 0, 0];
		
		for (i in 0...7)
		{
			if (binaryString.length > i)
				array.push(Std.parseFloat(binaryString.charAt(i)));
			else
				array.push(0);
		}
	
		return array;
	}
	
}