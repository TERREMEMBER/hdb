package DataMining_HITS;

/**
 * HITS¡¥Ω”∑÷ŒˆÀ„∑®
 */
public class Client {
	public static void main(String[] args){
		String filePath = "C:\\Users\\lyq\\Desktop\\icon\\input.txt";
		
		HITSTool tool = new HITSTool(filePath);
		tool.printResultPage();
	}
}
