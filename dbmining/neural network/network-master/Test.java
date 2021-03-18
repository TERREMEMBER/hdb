package BP;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class BPTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BPNeuralNetwork bp =new  BPNeuralNetwork();
		BPNeuralNetwork bpRandom =new  BPNeuralNetwork();
		List<titanic> trainList = new ArrayList<titanic>();
		List<titanic> testList = new ArrayList<titanic>();
		Random r = new Random();
		//初始化神经元层
		int layerNum[]={3,4,1};
		bp.initial(layerNum);
		bpRandom.initial(layerNum);
		//最大最小值
		double maxclas=-99,minclas=99;
		double maxage=-99,minage=99;
		double maxsex=-99,minsex=99;
		double maxsurvived=-99,minsurvived=99;
		//获取最大最小值
		try{
			FileReader fr = new FileReader("d:/titanic.dat");
			BufferedReader bf = new BufferedReader(fr);
			String  str =null;
			int count = 0;
			while((str=bf.readLine())!=null){
				if(count>7){
					String [] splitArray = str.split(",");
					double tempclas = Double.parseDouble(splitArray[0]);
					double tempage = Double.parseDouble(splitArray[1]);
					double tempsex = Double.parseDouble(splitArray[2]);
					double tempsurvived = Double.parseDouble(splitArray[3]);
					if(tempclas>maxclas){
						maxclas = tempclas;
					}
					if(tempclas<minclas){
						minclas = tempclas;
					}
					if(tempage>maxage){
						maxage = tempage;
					}
					if(tempage<minage){
						minage = tempage;
					}
					if(tempsex>maxsex){
						maxsex = tempsex;
					}
					if(tempsex<minsex){
						minsex = tempsex;
					}
					if(tempsurvived>maxsurvived){
						maxsurvived = tempsurvived;
					}
					if(tempsurvived<minsurvived){
						minsurvived = tempsurvived;
					}
				}
			count++;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		try {
			FileReader fr = new FileReader("d:/titanic.dat");
			BufferedReader bf = new BufferedReader(fr);
			String  str =null;
			int count = 0;
//			System.out.println(maxclas+" "+minclas);
//			System.out.println(maxage+" "+minage);
//			System.out.println(maxsex+" "+minsex);
//			System.out.println(maxsurvived+" "+minsurvived);
				while((str=bf.readLine())!=null){
					if(count>7){
					String [] splitArray = str.split(",");
					double tempclas = (Double.parseDouble(splitArray[0])-minclas)/(maxclas-minclas);
					double tempage = (Double.parseDouble(splitArray[1])-minage)/(maxage-minage);
					double tempsex = (Double.parseDouble(splitArray[2])-minsex)/(maxsex-minsex);
					double tempsurvived = (Double.parseDouble(splitArray[3])-minsurvived)/(maxsurvived-minsurvived);
					titanic tt = new titanic();
					tt.setclas(tempclas);
					tt.setAge(tempage);
					tt.setSex(tempsex);
					tt.setSurvived(tempsurvived);
//					System.out.println(tempclas+" "+tempage+" "+tempsex+" "+tempsurvived);
					if(!getTrainSet(r)){
						trainList.add(tt);
					}else{
						testList.add(tt);
					}
					
				}
			count++;
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//使用训练集训练神经网络单元
		int kk=3000;
		while(kk-->0){
			for(int i=0;i<trainList.size();i++){
				titanic temptt = trainList.get(i);
				double []tempInputArray ={temptt.getclas(),temptt.getAge(),temptt.getSex()};
				double []tempOutputArray ={temptt.getSurvived()};
				double []tempresult = bp.forward(tempInputArray);
				double []temperror = bp.backpropagate(tempOutputArray);
				bpRandom.forward(tempInputArray);
				bpRandom.backpropagate(tempOutputArray);
				
//				System.out.println("round:"+kk+":"+i+":"+tempresult[0]+" "+temptt.getSurvived()+" "+temperror[0]);
				
			}
		}
		double countSize= 0;
		double countRightSize = 0;
		double countSizeRandom= 0;
		double countRightSizeRandom = 0;
		for(int i=0;i<testList.size();i++){
			titanic temptt = trainList.get(i);
			//backpropagate
			double []tempInputArray ={temptt.getclas(),temptt.getAge(),temptt.getSex()};
			double []tempresult =bp.forward(tempInputArray);
			double rs = 0.0;
			if(tempresult[0]>0.5){
				rs=1.0;
			}else{
				rs=0.0;
			}
			countSize++;
			if(rs==temptt.getSurvived()){
				countRightSize++;
			}
			//random backpropagate
			double []tempInputArrayRandom ={temptt.getclas(),temptt.getAge(),temptt.getSex()};
			double []tempresultRandom =bpRandom.forward(tempInputArrayRandom);
			double rsRandom = 0.0;
			if(tempresultRandom[0]>0.5){
				rsRandom=1.0;
			}else{
				rsRandom=0.0;
			}
			countSizeRandom++;
			if(rsRandom==temptt.getSurvived()){
				countRightSizeRandom++;
			}
			
		}
		System.out.println("back propagate algorithm correctness:"+countRightSize/countSize);
		System.out.println("random back propagate algorithm correctness:"+countRightSizeRandom/countSizeRandom);
	}

	/**
	 * get random rate
	 * @param r
	 * @return
	 */
	public static boolean getTrainSet(Random r){
		if(r.nextDouble()>=0.7){
			return true;
		}
		else{
			return false;
		}
		
	}
}
