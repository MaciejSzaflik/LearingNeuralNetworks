package nobody;
import moon.ai.neural.Layer;
import moon.ai.neural.Network;
import moon.ai.neural.Trainer;

/**
 * ...
 * @author 
 */
class XorNetwork
{
	var network : Network;
	var inputLayer : Layer;
	var hiddenFirst : Layer;
	var hiddenSecond : Layer;
	var outputLayer : Layer;
	public function new() 
	{
		inputLayer = new Layer(2);
		hiddenFirst = new Layer(4);
		hiddenSecond = new Layer(4);
		outputLayer = new Layer(1);
		
		inputLayer.project(hiddenSecond);
		hiddenFirst.project(hiddenFirst);
		hiddenSecond.project(outputLayer);
		
		network = new Network({
			input : inputLayer,
			hidden : [hiddenFirst,hiddenSecond],
			output : outputLayer
		});
	}
	
	public function getOutput(input : Array<Float>)
	{	
		trace("For: " + input);
		trace(network.activate(input)[0]);
	}
	
	public function train()
	{
		var trainer = new Trainer(network);
		
		var trainData = new TrainingSet();
		trainData.push({input : [0.0, 0.0], output : [0]});
		trainData.push({input : [0.0, 1.0], output : [1]});
		trainData.push({input : [1.0, 0.0], output : [1]});
		trainData.push({input : [1.0, 1.0], output : [0]});
		
		trainer.train(trainData,{
			rate: 0.2,
			iterations: 100000,
			error: 0.005,
			shuffle: true,
			log: 0,
			cost: TrainerCost.crossEntropy
		});
	}
	
	
	
}