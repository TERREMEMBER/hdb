package BP;

import java.util.Random;

public class BPNeuralNetwork {
	Random r;
	double [][] layer;//单元值
	double [][] layerError;//误差
	double [][][] layerWeight;//权重
	double [][][] layerDelta;//动量
	double rate = 0.15;//学习率
	double mobp = 1;
	
	public void initial(int []layerNum){
		r = new Random();
		layer = new double[layerNum.length][];
		layerError = new double[layerNum.length][];
		layerWeight = new double[layerNum.length][][];
		layerDelta = new double [layerNum.length][][];
		for(int i=0;i<layerNum.length;i++){
			if(i<layerNum.length-1){
				layer[i] = new double[layerNum[i]+1];//每层增加一个偏置单元
				layerError[i] = new double[layerNum[i]];//偏置误差// layerNum[i]+1
				layer[i][layerNum[i]] = 1.0;//初始化截距为1
				layerWeight[i] = new double[layerNum[i]+1][];
				layerDelta[i] = new double[layerNum[i]+1][];
			}else{//最后一层无偏置单元
				layer[i] = new double[layerNum[i]+1];
				layerError[i] = new double[layerNum[i]];
			}
		}
		//初始化权重与动量
		for(int i=0;i<layer.length-1;i++){
			for(int j=0;j<layer[i].length;j++){
				layerWeight[i][j] = new double[layer[i+1].length-1];// length ->length-1
				layerDelta[i][j] = new double[layer[i+1].length-1];
				for(int l=0;l<layer[i+1].length-1;l++){
//					System.out.println(layer[i+1].length-1);
//					System.out.println("initial:"+i+" "+j+" "+" "+l);
					layerWeight[i][j][l] = r.nextDouble();
					//layerDelta[i][j][l] = 0.0;
				}
			}
		}
	}
	
	/**
	 * forward input to output
	 * @param inputArray
	 * @return output result
	 */
	public double[] forward(double []inputArray){
		for(int i=1;i<layer.length;i++){
			int tempnum = i;
			for(int j=0;j<layer[i].length-1;j++){//xiugai length->length-1
				double temp = 0.0;
				if(i==1){
					for(int k=0;k<layer[i-1].length-1;k++){//xiugai inputArray.length ->layer[i-1].length-1 ->length
//						System.out.println(layer[i-1].length-1);
//						System.out.println(i+" "+j+" "+k);
						temp+=layerWeight[i-1][k][j]*inputArray[k];
					}
					temp+=layerWeight[i-1][layer[i-1].length-1][j]*layer[i-1][layer[i-1].length-1];
				}else{
					for(int k=0;k<layer[i-1].length;k++){
						temp+=layerWeight[i-1][k][j]*layer[i-1][k]; 
					}
				}
//				System.out.println(i+" "+j+" "+layer[i][j]);		
				layer[i][j] = sigmoid(temp);
			}
		}
		return layer[layer.length-1];
	}
	
	public double[] backpropagate(double []target){
		int l = layer.length-1;
//		System.out.println("length:"+(l+1));
		//输出层误差
		for(int i=0;i<layerError[l].length;i++){
			layerError[l][i] = layer[l][i]*(1-layer[l][i])*(target[i]-layer[l][i]);//xiugai qudiao abs zengjia sigmoid
		}
		//输出层之前层的误差
		while(--l>=0){//////xiugai =0
			for(int i=0;i<layer[l].length;i++){//xiugaiwei -1
				double tempError = 0.0;
				for(int j=0;j<layer[l+1].length-1;j++){//-1去除偏置单元
					layerWeight[l][i][j]+=rate*layerError[l+1][j]*layer[l][i]; 
					tempError+=layerWeight[l][i][j]*layerError[l+1][j];
				}
				//去除偏置单元情况
				if(i<layer[l].length-1){
					layerError[l][i]=layer[l][i]*(1-layer[l][i])*tempError;//xiugai
				}
			}
		}
		return layerError[layer.length-1];
	}
	
	/**
	 * random backpropagate
	 * @param target
	 * @return
	 */
	public double[] randombackpropagate(double []target){
		int l = layer.length-1;
//		System.out.println("length:"+(l+1));
		//输出层误差
		for(int i=0;i<layerError[l].length;i++){
			if(randomDigest(r)){
				layerError[l][i] = layer[l][i]*(1-layer[l][i])*(target[i]-layer[l][i]);//xiugai qudiao abs zengjia sigmoid
			}
		}
		//输出层之前层的误差
		while(--l>=0){//////xiugai =0
			for(int i=0;i<layer[l].length;i++){//xiugaiwei -1
				if(randomDigest(r)){
					double tempError = 0.0;
					for(int j=0;j<layer[l+1].length-1;j++){//-1去除偏置单元
						layerWeight[l][i][j]+=rate*layerError[l+1][j]*layer[l][i]; 
						tempError+=layerWeight[l][i][j]*layerError[l+1][j];
					}
					//去除偏置单元情况
					if(i<layer[l].length-1){
						layerError[l][i]=layer[l][i]*(1-layer[l][i])*tempError;//xiugai
					}
				}
			}
				
		}
		return layerError[layer.length-1];
	}
	
	/**
	 * return z's sigmoid
	 * @param z
	 * @return
	 */
	public double sigmoid(double z){
		return 1.0/(1.0+Math.exp(-z));
	}

	/**
	 * get random value
	 * @param r
	 * @return
	 */
	public boolean randomDigest(Random r){
		double x = r.nextDouble();
		if(x<0.25){
			return true;
		}else{
			return false;
		}
	}
}
