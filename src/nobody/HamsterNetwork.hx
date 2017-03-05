package nobody;
import moon.ai.neural.Layer;
import thx.Tuple.Tuple2;

/**
 * ...
 * @author 
 */
class HamsterNetwork
{
	var input : Layer;
	var output : Layer;
	var learingRate : Float = 0.4; 
	var traingData : Array <Tuple2<Array<Float>, Array<Float>>>;
	
	public function new() 
	{
		input = new Layer(2);
		output = new Layer(3);
		
		input.project(output);
		
		preparaTrainingData();
	}
	
	private function preparaTrainingData()
	{
		traingData = new Array<Tuple2<Array<Float>, Array<Float>>>();
		traingData.push(new Tuple2([1.0, 0.0], [1.0, 0.0, 0.0]));
		traingData.push(new Tuple2([0.0, 0.0], [0.0, 1.0, 0.0]));
		traingData.push(new Tuple2([1.0, 1.0], [0.0, 0.0, 1.0]));
	}
	
	public function train()
	{
		for ( i in  0...traingData.length)
		{
			input.activate(traingData[i]._0);
			output.activate();
			output.propagate(learingRate, traingData[i]._1);
		}
	}
	
	public function retrain()
	{
		for ( i in 0...1000)
		{
			Random.shuffle(traingData);
			train();
		}
	}
	
	public function getOutput(inputData : Array<Float>): Array<Float>
	{
		input.activate(inputData);
		return output.activate();
	}
}